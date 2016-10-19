module Auth.Models exposing (..)

import Json.Decode as Decode exposing (decodeString, (:=))
import String
import Base64


type Views
    = Register
    | Login


type alias Model =
    { username : String
    , password : String
    , remember : Bool
    , token : String
    , view : Views
    }


type alias TokenPayload =
    { username : String
    , iat : Int
    , exp : Int
    }


init : Model
init =
    Model "" "" False "" Login


tokenPayloadDecoder : Decode.Decoder TokenPayload
tokenPayloadDecoder =
    Decode.object3 TokenPayload
        ("username" := Decode.string)
        ("iat" := Decode.int)
        ("exp" := Decode.int)


base64Decode : String -> String
base64Decode encodedString =
    case Base64.decode encodedString of
        Ok payload ->
            String.slice 0 -1 payload

        Err _ ->
            ""


decodeTokenPayloadString : String -> TokenPayload
decodeTokenPayloadString payload =
    case decodeString tokenPayloadDecoder payload of
        Ok payload ->
            payload

        Err _ ->
            TokenPayload "username" 0 0


decodeTokenPayload : String -> TokenPayload
decodeTokenPayload token =
    case List.head (String.split "." token) of
        Just encodedPayload ->
            decodeTokenPayloadString <| base64Decode encodedPayload

        Nothing ->
            TokenPayload "username" 0 0
