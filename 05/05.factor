USING: arrays combinators.extras grouping io.encodings.utf8
io.files kernel math math.parser path-finding sequences
sequences.extras sets splitting ;
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

: update-astar ( -- astar )
  [
    dup 2 clump
    [ dup reverse 2array ] map
    [ first2 replace ] with map
  ] [ 2drop 1 ] [ 2drop 1 ] <astar> ;

: correct-update ( rules update -- update' )
  [ compliant? ] with update-astar find-path* last ;

: part2 ( -- n )
  get-input dupd
  [ compliant? ] with reject
  [ correct-update middle-number ] with map-sum ;
