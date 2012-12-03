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
        raise ArgumentError.new 'Argument must be Fixnum'   if (arg.class != Fixnum)
        raise ArgumentError.new 'Argument must be positive' if (arg != arg.abs)
        raise ArgumentError.new 'Argument must be integer'  if (!arg.integer?)
      end
    end
  end
end
