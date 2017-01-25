module Card exposing (render)

import Html exposing (span, text)
import Html.Attributes exposing (style)
import Maybe exposing (withDefault)
import Array exposing (fromList, get)
import List exposing (member)

ranks = fromList ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
suits = fromList ["♣", "♦", "♥", "♠"]

rank card = get ((card-1) % 13) ranks |> withDefault "error"

suit card = get ((card - 1) // 13) suits |> withDefault "error"

color card = if member (suit card) ["♣", "♠"] then "#333" else "#DC143C"

render card =
  span [style
    [
      ("color", color card),
      ("margin-right", "8px"),
      ("display", "inline-block"),
      ("font-size", "18pt")
      ]
      ] [text ((rank card) ++ (suit card))]
