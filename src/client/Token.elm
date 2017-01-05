module Token exposing (..)

import Json.Decode as Decode exposing (decodeString, field)
import String
import Base64


type alias Token =
    String


type alias TokenPayload =
    { username : String
    , iat : Float
    , exp : Float
    }


initTokenPayload : TokenPayload
initTokenPayload =
    TokenPayload "" 0.0 0.0



-- TokenPayload Decoder


tokenPayloadDecoder : Decode.Decoder TokenPayload
tokenPayloadDecoder =
    Decode.map3 TokenPayload
        (field "username" Decode.string)
        (field "iat" Decode.float)
        (field "exp" Decode.float)


fixBase64Length : String -> Result String String
fixBase64Length s =
    case String.length s % 4 of
        0 ->
            Result.Ok s

        2 ->
            Result.Ok <| String.concat [ s, "==" ]

        3 ->
            Result.Ok <| String.concat [ s, "=" ]

        _ ->
            Result.Err <| "Wrong length"


base64Decode : String -> String
base64Decode encodedString =
    case fixBase64Length encodedString of
        Ok fixedEncodedString ->
            case Base64.decode fixedEncodedString of
                Ok payload ->
                    payload

                Err error ->
                    ""

        Err error ->
            ""


decodeTokenPayloadString : String -> Maybe TokenPayload
decodeTokenPayloadString payload =
    case decodeString tokenPayloadDecoder payload of
        Ok payload ->
            Just payload

        Err error ->
            Nothing


decodeTokenPayload : Token -> Maybe TokenPayload
decodeTokenPayload token =
    case List.head (String.split "." token) of
        Just encodedPayload ->
            decodeTokenPayloadString <| base64Decode encodedPayload

        Nothing ->
            Nothing
