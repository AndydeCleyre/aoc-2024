USING: arrays assocs combinators.extras io.encodings.utf8
io.files kernel math math.matrices ranges sequences
sequences.extras ;
IN: aoc-2024.04

: get-input ( -- rows )
  "vocab:aoc-2024/04/input.txt" utf8 file-lines ;

: verticals ( rows -- lines )
  [ dimension last [0..b) ] keep cols ;

: slash-origins ( dimension -- coords )
  [ first [0..b) [ 0 2array ] map ] [
    first2 [ 1 - ] [ 1 (a..b] ] bi*
    [ 2array ] with map
  ] bi append ;

: backslash-origins ( dimension -- coords )
  first2
  [ [0..b) [ 0 2array ] map ]
  [ 1 (a..b] [ 0 swap 2array ] map ] bi* append ;

: slash ( rows origin -- line )
  first2
  [ 0 [a..b] ]
  [ pick dimension last [a..b) ] bi* zip
  swap matrix-nths ;

: backslash ( rows origin -- line )
  [ dup dimension ] dip first2
  [ over first [a..b) ]
  [ pick last [a..b) ] bi* zip nip
  swap matrix-nths ;

: slashes ( rows -- lines )
  dup dimension slash-origins
  [ slash ] with map ;

: backslashes ( rows -- lines )
  dup dimension backslash-origins
  [ backslash ] with map ;

: word-count ( word line -- n )
  dup reverse rot
  '[ _ subseq-indices length ] bi@ + ;

: part1 ( -- n )
  "XMAS" get-input
  { [ ] [ verticals ] [ slashes ] [ backslashes ] } cleave-array concat
  [ word-count ] with map-sum ;
