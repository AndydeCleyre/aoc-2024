USING: combinators.short-circuit.smart grouping kernel math
math.order math.parser sequences sequences.extras splitting
vocabs.metadata ;
IN: aoc-2024.02

: get-input ( -- reports )
  "aoc-2024.02" "input.txt" vocab-file-lines
  [ split-words [ string>number ] map ] map ;

: slanted? ( report -- ? )
  { [ [ > ] monotonic? ] [ [ < ] monotonic? ] } || ;

: gradual? ( report -- ? )
  [ - abs 1 3 between? ] monotonic? ;

: safe? ( report -- ? )
  { [ slanted? ] [ gradual? ] } && ;

: part1 ( -- n )
  get-input [ safe? ] count ;

: fuzzy-reports ( report -- reports )
  dup length <iota> [ remove-nth-of ] with map ;

: tolerable? ( report -- ? )
  { [ safe? ] [ fuzzy-reports [ safe? ] any? ] } || ;

: part2 ( -- n )
  get-input [ tolerable? ] count ;
