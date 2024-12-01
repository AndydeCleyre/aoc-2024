USING: assocs kernel math math.parser math.statistics sequences
sequences.extras sorting splitting vocabs.metadata ;
IN: aoc-2024.01

: get-input ( -- left-list right-list )
  "aoc-2024.01" "input.txt" vocab-file-lines
  [ split-words harvest ] map
  [ keys ] [ values ] bi
  [ [ string>number ] map ] bi@ ;

: part1 ( -- n )
  get-input
  [ sort ] bi@
  [ - abs ] 2map-sum ;

: part2 ( -- n )
  get-input
  histogram
  '[ dup _ at 0 or * ] map-sum ;
