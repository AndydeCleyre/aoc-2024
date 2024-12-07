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

: possible-quotations ( numbers -- quots )
  dup length 1 -
  { + * } swap all-selections
  [ unclip swap ] dip
  [ zip concat ] with map
  swap '[ _ prefix >quotation ] map ;

: possibly-true? ( equation -- ? )
  [ value>> ] [ numbers>> possible-quotations ] bi
  [ call( -- n ) = ] with any? ;

: part1 ( -- n )
  get-input [ possibly-true? ] [ value>> ] filter-map sum ;
