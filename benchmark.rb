# -*- coding: utf-8 -*-
require 'fluent/config'
require 'fluent/engine'
require 'fluent/parser'
require 'benchmark'
require 'time'

apache_combined_log = '172.21.65.11 - - [07/Jan/2014:16:09:26 +0900] "GET /mypage HTTP/1.1" 302 - "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.33 Safari/535.11"'
apache_ltsv_log = "host:192.128.10.11  user:-  time:07/Jan/2014:16:09:26 +0900  method:GET  path:/mypage  code:302  size:-  referer:-  agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.33 Safari/535.11"
time_format = "%d/%b/%Y:%H:%M:%S %z"

optimized_format = /^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +\S*)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$/
optimized_parser = Fluent::TextParser::RegexpParser.new(optimized_format, 'time_format' => time_format)

greedy_format = /^(?<host>.*) .* (?<user>.*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>.*) +\S*)?" (?<code>.*) (?<size>.*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$/
greedy_parser = Fluent::TextParser::RegexpParser.new(greedy_format, 'time_format' => time_format)

ltsv_parser = Fluent::TextParser::LabeledTSVParser.new()
ltsv_parser.configure({'time_format' => time_format})

n = 500000
Benchmark.bm(7) do |x|
  x.report("ltsv")  {  n.times { ltsv_parser.call(apache_ltsv_log) } }
  x.report("faster_regexp") { n.times { optimized_parser.call(apache_combined_log) } }
  x.report("greedy_regexp") { n.times { greedy_parser.call(apache_combined_log) } }
end
