USING: accessors assocs combinators combinators.extras
io.encodings.utf8 io.files kernel make math.matrices
math.vectors sequences sets ;
IN: aoc-2024.06

: get-input ( -- rows )
  "vocab:aoc-2024/06/input.txt" utf8 file-lines ;

: all-locations ( rows -- pairs )
  dimension <coordinate-matrix> concat ;

: guard-location ( rows -- pair )
  [ all-locations ] keep
  '[ _ matrix-nth "<>^v" in? ] find nip ;

TUPLE: state location char ;
C: <state> state

: guard-state ( rows -- state )
  [ guard-location ]
  [ dupd matrix-nth ] bi <state> ;

: faced-location ( state -- pair )
  [ char>> H{
    { CHAR: > { 0 1 } }
    { CHAR: v { 1 0 } }
    { CHAR: < { 0 -1 } }
    { CHAR: ^ { -1 0 } }
  } at ] [ location>> ] bi v+ ;

: off-grid? ( rows location -- ? )
  [ dimension ] dip
  [ v<= vany? ] keep
  { 0 0 } v< vany? or ;

: turn ( state -- state' )
  [ H{
    { CHAR: > CHAR: v }
    { CHAR: v CHAR: < }
    { CHAR: < CHAR: ^ }
    { CHAR: ^ CHAR: > }
  } at ] change-char ;

: obstacle? ( rows location -- ? )
  swap matrix-nth CHAR: # = ;

: guard-step ( rows state -- state' )
  swap over faced-location
  {
    { [ 2dup off-grid? ] [ 2nip f <state> ] }
    { [ [ obstacle? ] keep-under ] [ drop turn ] }
    [ >>location ]
  } cond ;

: walk-out ( rows state -- trail )
  [
    [ 2dup location>> off-grid? ] [
      dup location>> ,
      dupd guard-step
    ] until
  ] { } make 2nip ;

: part1 ( -- n )
  get-input dup guard-state walk-out cardinality ;
