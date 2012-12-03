require 'rpxem_helper'

describe RPxem do
  describe 'delegation' do
    it 'RPxem.new => RPxem::Interpreter.new' do
      RPxem.new.class.should == RPxem::Interpreter.new.class
    end

    it 'RPxem.run => #<RPxem::Interpreter>.run' do
      RPxem.run('hoge.d').should == RPxem::Interpreter.new.run('hoge.d')
    end
  end

  describe RPxem::Stack do
    before do
      @stack = RPxem::Stack.new
    end

    it 'should be positive' do
      expect{ @stack.push(-1) }.to raise_error ArgumentError
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
        capture{ @pxem.run('.p', '', RPxem::Stack.new([99, 98, 97])) }.should == 'abc'
      end

      it 'can open file' do
        testfile = File.join(File.dirname(__FILE__), 'world!.fHello,.pxe')
        capture{ @pxem.open(testfile) }.should == 'Hello, Pxem world!'
      end

      it 'can merge command mapping' do
        pxem = RPxem.new({'q' => 'output_all', 'c' => 'output_all'})
        capture{ pxem.run('Hi.q') }.should == 'Hi'
        capture{ pxem.run('Hi.c') }.should == 'Hi'
      end
    end

    describe 'get result' do
      it 'should return remaining stack' do
        @pxem.run('Hi.d').should == [105, 72]
      end

      it 'can read stack' do
        @pxem.run('a.d')
        @pxem.stack.should == [97]
      end

      it 'can read temp area' do
        @pxem.run('a.t')
        @pxem.temp.should == 97
      end
    end

    describe 'Pxem commands' do
      describe 'I/O' do
        it '.p' do
          capture{ @pxem.run('Hello, world!.p') }.should == 'Hello, world!'
        end

        it '.o' do
          capture{ @pxem.run('Hi.o') }.should == 'H'
        end

        it '.n' do
          capture{ @pxem.run('Hi.n') }.should == '72'
        end

        #it '.i' do
        #end

        #it '._' do
        #end
      end

      describe 'Stack' do
        it '.c' do
          @pxem.run('Hi.c').should == [105, 72, 72]
        end

        it '.s' do
          @pxem.run('Hi.s').should == [105]
        end

        it '.v' do
          @pxem.run('Hi.v').should == [72, 105]
        end
      end

      describe 'File' do
        it '.f' do
          @pxem.run('.f', 'File').should == [101, 108, 105, 70]
        end

        it '.e' do
          @pxem.run('.e', 'File.d').should == [101, 108, 105, 70]
        end
      end

      describe 'Rand' do
        it '.r' do
          @pxem.run('d.r').first.should be_within(100).of(0)
        end
      end

      describe 'Loop' do
        it '.w' do
          capture{ @pxem.run('a.whoge.paa.-.a') }.should == 'hoge'
        end

        it '.x' do
          capture{ @pxem.run('e.xhog.pba.a') }.should == 'hoge'
        end

        it '.y' do
          capture{ @pxem.run('e.yhog.pab.a') }.should == 'hoge'
        end

        it '.z' do
          capture{ @pxem.run('e.zhog.paa.a') }.should == 'hoge'
        end

        it '.a' do
          capture{ @pxem.run('e.zhog.pe.zhog.paa.aaa.a') } == 'hogehoge'
        end
      end

      describe 'Temporary area' do
        it '.t' do
          @pxem.run('a.t')
          @pxem.temp.should == 97
        end

        it '.m' do
          @pxem.run('a.t.m.m').should == [97, 97]
        end
      end

      describe '.d' do
        it '.d' do
          @pxem.run('Hi.d').should == [105, 72]
        end
      end

      describe 'Math' do
        it '.+' do
          @pxem.run('ab.+').should == [98 + 97]
          @pxem.run('ba.+').should == [98 + 97]
        end

        it '.-' do
          @pxem.run('ab.-').should == [98 - 97]
          @pxem.run('ba.-').should == [98 - 97]
        end

        it '.!' do
          @pxem.run('ab.!').should == [98 * 97]
          @pxem.run('ba.!').should == [98 * 97]
        end

        it '.$' do
          @pxem.run('ab.$').should == [98 / 97]
          @pxem.run('ba.$').should == [98 / 97]
        end

        it '.%' do
          @pxem.run('ab.%').should == [98 % 97]
          @pxem.run('ba.%').should == [98 % 97]
        end
      end
    end
  end
end
