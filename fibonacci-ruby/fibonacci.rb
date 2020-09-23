# n0: 0
# n1: 1
# n2: 1
#
# n3: 2
# n4: 3
# n5: 5
# n6: 8
# ...
#
# xは3以上
# nx = n(x-1) + n(x-2)とも表現可能
# or
# yは0以上
# n(y+2) = n(y) + n(y+1)とも表現可能

require 'benchmark'

N0 = 30.freeze
N1 = 35.freeze
N2 = 9_000.freeze
N3 = 10_000.freeze

def fibonacci1(n:)
  return   if n < 0
  return n if n < 2
  fibonacci1(n: n-1) + fibonacci1(n: n-2)
end

# +メモ化
# n: 10_000だとスタックオーバーフロー
def fibonacci2(n:)
  memo = {}
  l = lambda do |m|
    return   if m < 0
    return m if m < 2
    memo[m] ||= l[m-1] + l[m-2]
  end
  l.call(n)
end

# スマートなやり方
def fibonacci3(n:)
  return   if n < 0
  return n if n < 2
  a, b = 0, 1
  n.times { a, b = b, a+b }
  a
end


def test1
  ans = nil
  result = Benchmark.realtime do
    ans = fibonacci1(n: N1)
  end
  p result
  puts ans
end

def test2
  ans = nil
  result = Benchmark.realtime do
    ans = fibonacci2(n: N2)
  end
  p result
  puts ans
end

def test3
  ans = nil
  result = Benchmark.realtime do
    ans = fibonacci3(n: N2)
  end
  p result
  puts ans
end



#test1()
#test2()
test3()
