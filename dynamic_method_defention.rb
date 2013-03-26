require 'benchmark'

class Metric
  N = 1_000_000

  def self.class_eval_with_string
    N.times do |i|
      class_eval(<<-eorb, __FILE__, __LINE__ + 1)
        def smeth_#{i}
          #{i}
        end
      eorb
    end
  end

  def self.with_define_method
    N.times do |i|
      define_method("dmeth_#{i}") do
        i
      end
    end
  end
end

Benchmark.bm(22) do |x|
  x.report("class_eval with string") { Metric.class_eval_with_string }
  x.report("define_method")          { Metric.with_define_method     }

  metric = Metric.new
  x.report("string method")  { Metric::N.times { metric.smeth_1 } }
  x.report("dynamic method") { Metric::N.times { metric.dmeth_1 } }
end
