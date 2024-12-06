USING: assocs combinators combinators.extras io.encodings.utf8
io.files kernel make math.matrices math.vectors sequences sets
shuffle ;
IN: aoc-2024.06

: get-input ( -- rows )
  "vocab:aoc-2024/06/input.txt" utf8 file-lines ;

: all-locations ( rows -- pairs )
  dimension <coordinate-matrix> concat ;

: guard-location ( rows -- pair )
  [ all-locations ] keep
  '[ _ matrix-nth "<>^v" in? ] find nip ;

: guard-state ( rows -- location char )
  [ guard-location dup ] keep matrix-nth ;

: faced-location ( location char -- pair )
  H{
    { CHAR: > { 0 1 } }
    { CHAR: v { 1 0 } }
    { CHAR: < { 0 -1 } }
    { CHAR: ^ { -1 0 } }
  } at v+ ;

: off-grid? ( rows location -- ? )
  [ dimension ] dip
  [ v<= vany? ] keep
  { 0 0 } v< vany? or ;

: turn ( char -- char' )
  H{
    { CHAR: > CHAR: v }
    { CHAR: v CHAR: < }
    { CHAR: < CHAR: ^ }
    { CHAR: ^ CHAR: > }
  } at ;

: obstacle? ( rows location -- ? )
  swap matrix-nth CHAR: # = ;

: (guard-step) ( location char rows faced-location -- location' char'/f )
  {
    { [ 2dup off-grid? ] [ 3nip f ] }
    { [ [ obstacle? ] keep-under ] [ drop turn ] }
    [ -rot nip ]
  } cond ;

: guard-step ( rows location char -- location' char'/f )
  rot 2over faced-location (guard-step) ;

: part1 ( -- n )
  get-input dup guard-state  ! rows loc char
  [
    [ 2over off-grid? ]
    [ over , dupdd guard-step ] until
  ] { } make cardinality 3nip ;
