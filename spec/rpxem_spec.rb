require 'rpxem_helper'

describe RPxem do
  describe 'delegation' do
    it 'RPxem.new => RPxem::Interpreter.new' do
      expect(RPxem.new.class).to eq(RPxem::Interpreter.new.class)
    end

    it 'RPxem.run => #<RPxem::Interpreter>.run' do
      expect(RPxem.run('hoge.d')).to eq(RPxem::Interpreter.new.run('hoge.d'))
    end
  end

  describe RPxem::Stack do
    before do
      @stack = RPxem::Stack.new
    end

    it 'should accept a positive integer' do
      expect{ @stack.push(1) }.not_to raise_error
    end

    it 'should accept a negative integer' do
      expect{ @stack.push(-1) }.not_to raise_error
    end

    it 'can be zero' do
      expect{ @stack.push(0) }.not_to raise_error
    end

    it 'can be Bignum' do
      expect{ @stack.push(13**13) }.not_to raise_error
    end

    it 'should be integer' do
      expect{ @stack << 'a' }.to raise_error ArgumentError
      expect{ @stack << 0.1 }.to raise_error ArgumentError
    end

    it 'can check in #new' do
      expect{ RPxem::Stack.new([1, 2, 'san']) }.to raise_error ArgumentError
    end
  end

  describe RPxem::Interpreter do
    before do
      @pxem = RPxem.new
    end

    describe 'initializing' do
      it 'can set initial stack' do
        expect(capture{ @pxem.run('.p', '', RPxem::Stack.new([99, 98, 97])) }).to eq('abc')
      end

      it 'can open file' do
        testfile = File.join(File.dirname(__FILE__), 'world!.fHello,.pxe')
        expect(capture{ @pxem.open(testfile) }).to eq('Hello, Pxem world!')
      end

      it 'can merge command mapping' do
        pxem = RPxem.new({'q' => 'output_all', 'c' => 'output_all'})
        expect(capture{ pxem.run('Hi.q') }).to eq('Hi')
        expect(capture{ pxem.run('Hi.c') }).to eq('Hi')
      end
    end

    describe 'get result' do
      it 'should return remaining stack' do
        expect(@pxem.run('Hi.d')).to eq([105, 72])
      end

      it 'can read stack' do
        @pxem.run('a.d')
        expect(@pxem.stack).to eq([97])
      end

      it 'can read temp area' do
        @pxem.run('a.t')
        expect(@pxem.temp).to eq(97)
      end
    end

    describe 'Pxem commands' do
      describe 'I/O' do
        it '.p' do
          expect(capture{ @pxem.run('Hello, world!.p') }).to eq('Hello, world!')
        end

        it '.o' do
          expect(capture{ @pxem.run('Hi.o') }).to eq('H')
        end

        it '.n' do
          expect(capture{ @pxem.run('Hi.n') }).to eq('72')
        end

        #it '.i' do
        #end

        #it '._' do
        #end
      end

      describe 'Stack' do
        it '.c' do
          expect(@pxem.run('Hi.c')).to eq([105, 72, 72])
        end

        it '.s' do
          expect(@pxem.run('Hi.s')).to eq([105])
        end

        it '.v' do
          expect(@pxem.run('Hi.v')).to eq([72, 105])
        end
      end

      describe 'File' do
        it '.f' do
          expect(@pxem.run('.f', 'File')).to eq([101, 108, 105, 70])
        end

        it '.e' do
          expect(@pxem.run('.e', 'File.d')).to eq([101, 108, 105, 70])
        end
      end

      describe 'Rand' do
        it '.r' do
          expect(@pxem.run('d.r').first).to be_within(100).of(0)
        end
      end

      describe 'Loop' do
        it '.w' do
          expect(capture{ @pxem.run('a.whoge.paa.-.a') }).to eq('hoge')
        end

        it '.x' do
          expect(capture{ @pxem.run('e.xhog.pba.a') }).to eq('hoge')
        end

        it '.y' do
          expect(capture{ @pxem.run('e.yhog.pab.a') }).to eq('hoge')
        end

        it '.z' do
          expect(capture{ @pxem.run('e.zhog.paa.a') }).to eq('hoge')
        end

        it '.a' do
          capture{ @pxem.run('e.zhog.pe.zhog.paa.aaa.a') } == 'hogehoge'
        end
      end

      describe 'Temporary area' do
        it '.t' do
          @pxem.run('a.t')
          expect(@pxem.temp).to eq(97)
        end

        it '.m' do
          expect(@pxem.run('a.t.m.m')).to eq([97, 97])
        end
      end

      describe '.d' do
        it '.d' do
          expect(@pxem.run('Hi.d')).to eq([105, 72])
        end
      end

      describe 'Math' do
        it '.+' do
          expect(@pxem.run('ab.+')).to eq([98 + 97])
          expect(@pxem.run('ba.+')).to eq([98 + 97])
        end

        it '.-' do
          expect(@pxem.run('ab.-')).to eq([98 - 97])
          expect(@pxem.run('ba.-')).to eq([98 - 97])
        end

        it '.!' do
          expect(@pxem.run('ab.!')).to eq([98 * 97])
          expect(@pxem.run('ba.!')).to eq([98 * 97])
        end

        it '.$' do
          expect(@pxem.run('ab.$')).to eq([98 / 97])
          expect(@pxem.run('ba.$')).to eq([98 / 97])
        end

        it '.%' do
          expect(@pxem.run('ab.%')).to eq([98 % 97])
          expect(@pxem.run('ba.%')).to eq([98 % 97])
        end
      end
    end
  end
end
