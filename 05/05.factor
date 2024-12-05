USING: arrays combinators.extras io.encodings.utf8 io.files
kernel math math.order math.parser sequences sequences.extras
sets sorting splitting ;
IN: aoc-2024.05

: get-input ( -- rules updates )
  "vocab:aoc-2024/05/input.txt" utf8 file-lines
  { "" } split1
  "|" "," [ '[ [ _ split ] map ] ] bi@ bi* ;

: relevant-rules ( rules update -- rules' )
  '[ [ _ in? ] all? ] filter ;

: compliant? ( rules update -- ? )
  [ relevant-rules ] keep-under
  [ [ index* ] with map first2 < ] with all? ;

: middle-number ( update -- n )
  dup length 2 /i nth-of string>number ;

: part1 ( -- n )
  get-input
  [ compliant? ] with
  [ middle-number ] filter-map sum ;

: compare-pages ( rules page1 page2 -- <=> )
  [ 2array relevant-rules ] keep-under
  [ drop +eq+ ] [ first index zero? +gt+ +lt+ ? ] if-empty ;

: correct-update ( rules update -- update' )
  [ swapd compare-pages ] with sort-with ;

: part2 ( -- n )
  get-input dupd
  [ compliant? ] with reject
  [ correct-update middle-number ] with map-sum ;
