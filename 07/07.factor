USING: accessors assocs io.encodings.utf8 io.files kernel math
math.combinatorics math.parser quotations sequences
sequences.extras splitting ;
IN: aoc-2024.07

TUPLE: equation value numbers ;
C: <equation> equation

: get-input ( -- equations )
  "vocab:aoc-2024/07/input.txt" utf8 file-lines [
    split-words unclip but-last string>number
    swap [ string>number ] map <equation>
  ] map ;

: possible-quotations ( funcs numbers -- quots )
  dup length 1 -
  swapd all-selections
  [ unclip swap ] dip
  [ zip concat ] with map
  swap '[ _ prefix >quotation ] map ;

: possibly-true? ( funcs equation -- ? )
  [ numbers>> possible-quotations ] [ value>> ] bi
  '[ call( -- n ) _ = ] any? ;

: solve ( funcs -- n )
  get-input
  [ possibly-true? ] with filter
  [ value>> ] map-sum ;

: part1 ( -- n )
  { + * } solve ;

: _|| ( m n -- mn )
  [ number>string ] bi@ append string>number ;

: part2 ( -- n )
  { + * _|| } solve ;
