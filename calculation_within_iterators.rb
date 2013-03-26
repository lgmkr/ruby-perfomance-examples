require 'benchmark'

def n_func(array)
  array.inject({}) { |h, e| h[e] = e; h }
end

def n2_func(array)
  array.inject({}) { |h, e| h.merge(e => e) }
end

BASE_SIZE = 10

4.times do |factor|
  size   = BASE_SIZE * (10 ** factor)
  params = (0..size).to_a
  puts "_" * 60 + "\nSIZE: #{size}"
  Benchmark.bm(10) do |x|
    x.report("O(n)" ) { n_func(params)  }
    x.report("O(n2)") { n2_func(params) }
  end
end
