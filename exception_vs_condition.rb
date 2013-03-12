require 'benchmark'

class Obj
  def with_condition
    respond_to?(:mythical_method) ? self.mythical_method : nil
  end

  def with_rescue
    self.mythical_method
  rescue NoMethodError
    nil
  end
end

obj = Obj.new
N = 10_000_000

puts RUBY_DESCRIPTION

Benchmark.bm(15, "rescue/condition") do |x|
  rescue_report     = x.report("rescue:")    { N.times { obj.with_rescue  } }
  condition_report  = x.report("condition:") { N.times { obj.with_condition } }
  [rescue_report / condition_report]
end
