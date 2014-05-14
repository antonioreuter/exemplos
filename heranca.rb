require 'pp'

class A
  def initialize(opts={})
    @a = 1
  end
end

class B < A
  def initialize
    @b = 2
    super
  end
end

class C < A
  def initialize(opts={})
    super(opts)
    @a = opts[:a] if opts[:a]
    @c = 3
  end
end

b = B.new
pp b


c1 = C.new
pp c1

c2 = C.new({a: 4})
pp c2
