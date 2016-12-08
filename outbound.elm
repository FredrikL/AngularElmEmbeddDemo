port module Outbound exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Model = String
type Msg = 
  NoOp |
  UpdateField String |
  Send

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    UpdateField str -> (str, Cmd.none)
    Send -> (model, send model)

view : Model -> Html Msg
view model =
  div [] [
    text "Outbound",
    br [][],
    input [onInput UpdateField] [],
    button [onClick Send] [text "send"]
  ]

main = 
  Html.program
    {
    init = ("", Cmd.none),
    view = view,
    update = update,
    subscriptions = \model -> Sub.none
  }

port send : String -> Cmd msg