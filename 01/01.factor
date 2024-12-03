USING: assocs io.encodings.utf8 io.files kernel math math.parser
math.statistics sequences sequences.extras sorting splitting ;
IN: aoc-2024.01

: get-input ( -- left-list right-list )
  "vocab:aoc-2024/01/input.txt" utf8 file-lines
  [ split-words harvest ] map unzip
  [ [ string>number ] map ] bi@ ;

: part1 ( -- n )
  get-input
  [ sort ] bi@
  [ - abs ] 2map-sum ;

: part2 ( -- n )
  get-input
  histogram
  '[ dup _ at 0 or * ] map-sum ;
