require "benchmark/ips"

Benchmark.ips do |x|
  x.report("Run tests with coverage") do
    `COVERAGE=true rspec`
  end

  x.report("Run tests without coverage") do
    `rspec`
  end

  x.compare!
end
