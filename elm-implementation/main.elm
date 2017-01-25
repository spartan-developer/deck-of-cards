import Html exposing (program, div, h1, h2, button, span, text, hr)
import Html.Attributes exposing (disabled, style, class)
import Html.Events exposing (onClick)
import Random exposing (generate, int, minInt, maxInt, step, initialSeed)
import List exposing (map, range, head, tail, take, drop, isEmpty, length)
import Maybe exposing (withDefault)
import Deck exposing (newDeck, shuffle)
import Card

type alias Model = { deck : List Int, currentCard: Maybe Int }

type Msg = GenerateRandomInt | Shuffle Int | Draw | Reset

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = case msg of
  GenerateRandomInt -> (model, generate Shuffle (int minInt maxInt))
  Shuffle x ->
    let
      shuffledDeck = shuffle model.deck (initialSeed x)
    in
        ({model | deck = shuffledDeck}, Cmd.none)
  Draw ->
    let
        nextCard = head model.deck
        remainingCards = withDefault [] (tail model.deck)
    in
        ({model | currentCard = nextCard, deck = remainingCards}, Cmd.none)
  Reset -> ({model | deck = newDeck, currentCard = Nothing}, Cmd.none)

view {deck, currentCard} = div [class "container"] [
  Html.node "link" [ Html.Attributes.rel "stylesheet", Html.Attributes.href "bootstrap/bootstrap.min.css" ] [],
  Html.node "link" [ Html.Attributes.rel "stylesheet", Html.Attributes.href "bootstrap/bootstrap-theme.min.css" ] [],
  h1 [style [("text-align", "center")]] [text "Deck of Cards"],
  div [class "row"] [
    div [class "col-sm-2"] [h2 [style [("margin-top", "0")]] [text (toString (length deck) ++ " remaining: ")]],
    div [class "col-sm-10"] (map Card.render deck)
    ],
  hr [] [],
  case currentCard of
    Nothing -> text ""
    Just cardNumber -> div [class "row"] [
      div [class "col-sm-2"] [h2 [style [("margin-top", "0")]] [text "You drew:"]],
      div [class "col-sm-10"] [Card.render cardNumber]
      ],
  div [style [("text-align", "center")]] [
    button [disabled (length deck < 2), onClick GenerateRandomInt, class "btn btn-info margin"] [text "Shuffle"],
    button [disabled (isEmpty deck), onClick Draw, class "btn btn-primary", style [("margin", "1em")]] [text "Draw Card"],
    button [onClick Reset, class "btn btn-warning"] [text "Reset"]
    ]
  ]

init = ({deck = newDeck, currentCard = Nothing}, Cmd.none)

main = Html.program { init = init, view = view, update = update, subscriptions = \model -> Sub.none }
