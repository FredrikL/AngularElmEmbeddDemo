port module Inbound exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model = String

type Msg =
  NoOp |
  Receive Model

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    Receive string -> (string, Cmd.none)

view : Model -> Html Msg
view model = 
  div [] [
    text ("Model is " ++ model)
  ]

main = 
  Html.program
   {
     init = ("", Cmd.none),
     view = view,
     update = update,
     subscriptions = subscriptions
   }

receiveMsg : String -> Msg
receiveMsg string =
  Receive string

subscriptions model =
  receive receiveMsg

port receive : (String -> msg) -> Sub msg
