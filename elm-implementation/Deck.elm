module Deck exposing (Deck, newDeck, shuffle)

import List exposing (range)
import Random exposing (Seed)
import Maybe exposing (withDefault)
import Array exposing (get, set, fromList, toList)
import Random exposing (generate, int, minInt, maxInt, step, initialSeed)

type alias Deck = List Int

newDeck = range 1 52

exchange i j deck =
  let
      old_i = withDefault 0 (get i deck)
      old_j = withDefault 0 (get j deck)
      deck_ = set i old_j deck
  in
      set j old_i deck_

shuffle : Deck -> Seed -> Deck
shuffle unshuffledDeck startSeed =
  let
      n = List.length unshuffledDeck
      iter i seed deck =
        if i > n-2
        then (toList deck)
        else
          let (j, nextSeed) = step (int i (n-1)) seed
          in iter (i+1) nextSeed (exchange i j deck)
  in
      iter 0 startSeed (fromList unshuffledDeck)
