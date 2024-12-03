USING: assocs grouping.extras io.encodings.utf8 io.files
math.parser pcre2 regexp sequences sequences.extras unicode
vocabs.metadata ;
IN: aoc-2024.03

: get-input ( -- corrupted-input )
  "aoc-2024.03" "input.txt" vocab-file-path utf8 file-contents ;

: get-muls ( corrupted-input -- instructions )
  R/ mul\(\d+,\d+\)/ all-matching-subseqs ;

: process-mul ( instruction -- n )
  R/ \d+/ all-matching-subseqs
  [ string>number ] map-product ;

: solve ( corrupted-input -- n )
  get-muls [ process-mul ] map-sum ;

: part1 ( -- n )
  get-input solve ;

: part2 ( -- n )
  get-input
  R/ don't\(\)(.|\n)*?do\(\)/ split concat
  R/ don't\(\)(.|\n)*/ "" re-replace
  solve ;
