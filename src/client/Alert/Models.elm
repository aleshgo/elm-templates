module Alert.Models exposing (..)

import Time


type AlertType
    = Success
    | Info
    | Warning
    | Error


type AlertPosition
    = TopLeft
    | TopCenter
    | TopRight
    | TopFull
    | BottomLeft
    | BottomCenter
    | BottomRight
    | BottomFull


alertTypeToStyle : AlertType -> String
alertTypeToStyle type' =
    case type' of
        Success ->
            "alert-success"

        Info ->
            "alert-info"

        Warning ->
            "alert-warning"

        Error ->
            "alert-error"


alertTypeToIcon : AlertType -> String
alertTypeToIcon type' =
    case type' of
        Success ->
            "fa-check-circle-o"

        Info ->
            "fa-info-circle"

        Warning ->
            "fa-exclamation-triangle"

        Error ->
            "fa-times-circle-o"


alertPositionToStyle : AlertPosition -> String
alertPositionToStyle position =
    case position of
        TopLeft ->
            "alert-top-left"

        TopCenter ->
            "alert-top-full"

        TopRight ->
            "alert-top-right"

        TopFull ->
            "alert-top-full"

        BottomLeft ->
            "alert-bottom-left"

        BottomCenter ->
            "alert-bottom-full"

        BottomRight ->
            "alert-bottom-right"

        BottomFull ->
            "alert-bottom-full"


type alias AlertMessage =
    { id : Float
    , type' : AlertType
    , title : String
    , text : String
    }


type alias Model =
    { queue : List AlertMessage
    , time : Float
    , position : AlertPosition
    }


init : Model
init =
    Model
        []
        0
        TopRight
