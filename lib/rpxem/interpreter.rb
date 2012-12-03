require 'rpxem/stack'
require 'rpxem/version'
require 'scanf'

module RPxem
  class Interpreter
    attr_accessor :mapping
    attr_reader   :stack, :temp

    def initialize(mapping={})
      @mapping = default_mapping().merge(mapping)
    end

    # Open and execute a Pxem file
    def open(file, stack=RPxem::Stack.new, temp=nil)
      run(File.basename(file), File.open(file).read, stack, temp)
    end

    # Execute a Pxem code
    def run(filename, source='', stack=RPxem::Stack.new, temp=nil)
      @filename, @source, @stack, @temp = filename.each_byte.to_a, source, stack, temp
      buffer, @cursor, length = RPxem::Stack.new, 0, @filename.length

      while (@cursor < length)
        char = @filename[@cursor]
        @cursor += 1
        if (@cursor < length && 46 == char && name = @mapping[@filename[@cursor].chr.downcase])
          @stack.push(*buffer)
          buffer = RPxem::Stack.new
          __send__(name)
          @cursor += 1
        else
          buffer.unshift(char)
        end
      end

      return @stack
    end

    def default_mapping
      {
        # I/O
        'p' => 'output_all',
        'o' => 'output',
        'n' => 'output_num',
        'i' => 'input',
        '_' => 'input_num',

        # Stack
        'c' => 'copy',
        's' => 'throw_away',
        'v' => 'reverse',

        # File contents
        'f' => 'read_file',
        'e' => 'emurate',

        # Rand
        'r' => 'rand',

        # Loop
        'w' => 'w',
        'x' => 'x',
        'y' => 'y',
        'z' => 'z',
        'a' => 'a',

        # Temporary area
        't' => 'to_temp',
        'm' => 'from_temp',

        # Do nothing
        'd' => 'void',

        # Math
        '+' => 'addition',
        '-' => 'subtraction',
        '!' => 'multiplication',
        '$' => 'quotient',
        '%' => 'surplus',
      }
    end

  private

    # .p:
    def output_all
      while output; end
    end

    # .o:
    def output
      putc @stack.pop unless @stack.empty?
    end

    # .n:
    def output_num
      print @stack.pop
    end

    # .i:
    def input
      @stack.push(*STDIN.getc.ord)
    end

    # ._:
    def input_num
      @stack.push(*scanf('%d'))
    end

    # .c:
    def copy
      @stack.push(@stack.last)
    end

    # .s:
    def throw_away
      @stack.pop
    end

    # .v:
    def reverse
      @stack.reverse!
    end

    # .f:
    def read_file
      @stack.push(*@source.each_byte.to_a.reverse)
    end

    # .e:
    def emurate
      @stack.push(*clone.run(@source, @source, @stack.clone))
    end

    # .r:
    def rand
      @stack.push((super * @stack.pop).to_i)
    end

    # .w:
    def w
      jump if (!@stack.empty? && 0 == @stack.pop)
    end

    # .x:
    def x
      jump if (2 <= @stack.size && @stack.pop >= @stack.pop)
    end

    # .y:
    def y
      jump if (2 <= @stack.size && @stack.pop <= @stack.pop)
    end

    # .z:
    def z
      jump if (2 <= @stack.size && @stack.pop == @stack.pop)
    end

    # Jump forward to correspondent .a
    def jump
      count = 1
      while (count.nonzero?)
        @cursor += 1
        if (46 == @filename[@cursor])
          if (['w','x','y','z'].include? @filename[@cursor+1].chr.downcase)
            count += 1
          elsif ('a' == @filename[@cursor+1].chr.downcase)
            count -= 1
  				end
        end
      end
      @cursor += 1
    end

    # .a:
    def a
      @cursor -= 2
      count = -1
      while (count.nonzero?)
        if (46 == @filename[@cursor])
          if (['w','x','y','z'].include? @filename[@cursor+1].chr.downcase)
            count += 1
          elsif ('a' == @filename[@cursor+1].chr.downcase)
            count -= 1
  				end
        end
        @cursor -= 1
      end
    end

    # .t:
    def to_temp
      @temp = @stack.pop
    end

    # .m:
    def from_temp
      @stack.push(@temp) if @temp
    end

    # .d:
    def void
    end

    # .+:
    def addition
      @stack.push(@stack.pop + @stack.pop) if 2 <= @stack.size
    end

    # .-: 
    def subtraction
      @stack.push((@stack.pop - @stack.pop).abs) if 2 <= @stack.size
    end

    # .!:
    def multiplication
      @stack.push(@stack.pop * @stack.pop) if 2 <= @stack.size
    end

    # .$:
    def quotient
      @stack.push((f=@stack.pop)>(s=@stack.pop)? f/s : s/f) if 2 <= @stack.size
    end

    # .%:
    def surplus
      @stack.push((f=@stack.pop)>(s=@stack.pop)? f%s : s%f) if 2 <= @stack.size
    end
  end
end
