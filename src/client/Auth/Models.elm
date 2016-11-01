module Auth.Models exposing (..)

import Json.Decode as Decode exposing (decodeString, (:=))
import String
import Base64


type Views
    = Register
    | Login


type alias Token =
    String


type alias TokenPayload =
    { username : String
    , iat : Float
    , exp : Float
    }


type alias Model =
    { username : String
    , password : String
    , remember : Bool
    , token : Maybe Token
    , tokenPayload : Maybe TokenPayload
    , view : Views
    }


initTokenPayload : TokenPayload
initTokenPayload =
    TokenPayload "" 0.0 0.0


init : Model
init =
    Model "" "" False Nothing Nothing Login



-- TokenPayload Decoder


tokenPayloadDecoder : Decode.Decoder TokenPayload
tokenPayloadDecoder =
    Decode.object3 TokenPayload
        ("username" := Decode.string)
        ("iat" := Decode.float)
        ("exp" := Decode.float)


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
                    Debug.log "Base64.decode: " payload

                Err error ->
                    let
                        _ =
                            Debug.log "Base64.decode error: " error
                    in
                        ""

        Err error ->
            let
                _ =
                    Debug.log "fixBase64Length error: " error
            in
                ""


decodeTokenPayloadString : String -> Maybe TokenPayload
decodeTokenPayloadString payload =
    case decodeString tokenPayloadDecoder payload of
        Ok payload ->
            Just payload

        Err error ->
            let
                _ =
                    Debug.log "decodeTokenPayloadString: " error
            in
                Nothing


decodeTokenPayload : Token -> Maybe TokenPayload
decodeTokenPayload token =
    case List.head (String.split "." token) of
        Just encodedPayload ->
            decodeTokenPayloadString <| base64Decode encodedPayload

        Nothing ->
            Nothing
