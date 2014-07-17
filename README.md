# fluentd_parser_benchmark

"fluentd_parser_benchmark" is a [Fluentd](http://www.fluentd.org/)[^1] parser benchmark tools.

## Usage

It could tune your regular expression for in_tail plugin to reduce load more and more!


    $ git clone https://github.com/y-ken/fluentd_parser_benchmark.git
    $ cd fluentd_parser_benchmark/
    $ bundle install --path vendor/bundle
    $ bundle exec ruby benchmark.rb

## Result

It shows a results that fast_regexp is more then 8 times faster than greedy_regex.

    $ bundle exec ruby benchmark.rb
                     user     system      total        real
    ltsv           4.950000   0.330000   5.280000 (  5.285332)
    faster_regexp 13.720000   0.000000  13.720000 ( 13.749062)
    greedy_regexp120.480000   0.010000 120.490000 (120.732407)

## TODO

patches welcome!

## Copyright

Copyright (C) 2014- Kentaro Yoshida (@yoshi_ken)

## License

Apache License, Version 2.0

[^1]: [Fluentd](http://www.fluentd.org/) is an open source data collector to simplify log management. Fluentd is designed to process high-volume data streams reliably. Use cases include real-time search and monitoring, Big Data analytics, reliable archiving and more.
