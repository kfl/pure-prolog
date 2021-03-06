What Is It?
===========

Simple-minded implementation of pure Prolog.


Interface
---------

The help message you get by calling `pure-prolog -?`:

~~~
Pure Prolog Interpreter v0.1, (C) Ken Friis Larsen 2012-2018

options [OPTIONS] [GOALSTRING]


Common flags:
  -s --search=SEARCH    Specify whether to use DFS, BFS, or Limited
  -p --program=FILE     Prolog file with clauses
  -l --limit=INT        Limit the number of solutions found
  -d --depth=INT        Maximum depth to traverse when using limited search
  -i --info=ANALYSIS    Don't interpret program, only analyse it
  -? --help             Display help message
  -V --version          Print version information
     --numeric-version  Print just the version number
~~~

Valid values for analysis are `External`, `Uses`, and `Interface`. If
you want see both which predicates are declared (the interface) and
which predicates are called (the uses) in the file `myprolog.pl` then
use the command:

~~~
  $ pure-prolog -p myprolog.pl -i interface -i uses
~~~

This will first print the interface (one predicate per line), then a
blank line, and finally the uses (one predicate per line).

If you just want a list of the external (or build-in) predicates that
are used, then use `-i external`.


How to install
--------------

~~~
  $ git clone https://github.com/kfl/pure-prolog.git
  $ cd pure-prolog
  $ stack install
~~~
