module Models exposing (..)

import Alert.Models exposing (AlertMessage, AlertPosition(..), AlertType(..), AlertOptions)
import Time exposing (Time)
import Nav.Models exposing (Page(..))
import Token exposing (Token, TokenPayload, decodeTokenPayload)
import String


type alias Model =
    { alert : Alert.Models.Model
    , token : Maybe Token
    , tokenPayload : Maybe TokenPayload
    , tokenTest : Maybe Bool
    , time : Time
    , page : Page
    , username : String
    , password : String
    , remember : Bool
    }


initialModel : Model
initialModel =
    { alert = Alert.Models.init TopRight (AlertOptions 5000 True True True True)
    , token = Nothing
    , tokenPayload = Nothing
    , tokenTest = Nothing
    , time = 0
    , page = Home
    , username = ""
    , password = ""
    , remember = False
    }


initModel : Maybe ModelStorage -> Time -> Model
initModel modelStorage time =
    case Debug.log "modelStorage" modelStorage of
        Just modelStorage ->
            { initialModel
                | token =
                    if String.isEmpty modelStorage.token then
                        Nothing
                    else
                        Just modelStorage.token
                , tokenPayload = decodeTokenPayload modelStorage.token
                , time = time
            }

        Nothing ->
            { initialModel | time = time }


type alias ModelStorage =
    { token : String
    , remember : Bool
    }


toModelStorage : Model -> ModelStorage
toModelStorage model =
    let
        token =
            case model.token of
                Nothing ->
                    ""

                Just token ->
                    token
    in
        ModelStorage token model.remember


tokenValid : Model -> Bool
tokenValid model =
    case model.tokenPayload of
        Nothing ->
            False

        Just tokenPayload ->
            round ((tokenPayload.exp - model.time) / 1000) > 0


tokenLeftTime : Model -> Int
tokenLeftTime model =
    case model.tokenPayload of
        Nothing ->
            0

        Just tokenPayload ->
            let
                leftTime =
                    round ((tokenPayload.exp - model.time) / 1000)
            in
                if leftTime > 0 then
                    leftTime
                else
                    0
