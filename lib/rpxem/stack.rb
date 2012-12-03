module RPxem
  class Stack < Array
    def initialize(*args, &block)
      super(*args, &block)
      simple_check(*self)
    end

    def push(*args, &block)
      simple_check(*args)
      super(*args, &block)
    end

    def unshift(*args, &block)
      simple_check(*args)
      super(*args, &block)
    end

    def <<(*args, &block)
      simple_check(*args)
      super(*args, &block)
    end

    def []=(*args, &block)
      super(*args, &block)
      simple_check(*self)
    end

    def insert(*args, &block)
      super(*args, &block)
      simple_check(*self)
    end

    def map!(*args, &block)
      super(*args, &block)
      simple_check(*self)
    end

  private
    def simple_check(*args)
      args.each do |arg|
        if (!arg.is_a? Integer)
          raise ArgumentError.new 'Argument must be Integer'
        elsif (arg != arg.abs)
          raise ArgumentError.new 'Argument must be positive'
        end
      end
    end
  end
end
