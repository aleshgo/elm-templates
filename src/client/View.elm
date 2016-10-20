module View exposing (..)

import Html exposing (Html, div, text, i)
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "flex items-center justify-center my-color bg-black my3" ]
        [ div [ class "mx1" ] [ text model ]
        , i [ class "fa fa-smile-o" ] []
        ]
