require 'benchmark'

def merge!(array)
  array.inject({}) { |h, e| h.merge!(e => e) }
end

def merge(array)
  array.inject({}) { |h, e| h.merge(e => e) }
end

N = 10_000
array = (0..N).to_a

Benchmark.bm(10) do |x|
  x.report("merge!") { merge!(array) }
  x.report("merge")  { merge(array)  }
end
