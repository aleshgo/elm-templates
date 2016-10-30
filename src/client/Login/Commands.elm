module Login.Commands exposing (signIn)

import Http
import Task

import Json.Encode
import Json.Decode
import Json.Decode.Pipeline

import Login.Models exposing (SignedUser, LoginModel)
import Login.Messages exposing (Msg(..))

signIn : LoginModel -> Cmd Msg
signIn model =
    Task.perform FetchFail FetchSucced
        <| getUserData model

getUserData model =
    let
        body =
            encodeModel model
                |> Json.Encode.encode 0
                |> Http.string

        config =
            { verb = "POST"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = fetchUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson decodeLoginModel


fetchUrl: String
fetchUrl =
    "http://localhost:8000/login"


-- decode


decodeLoginModel : Json.Decode.Decoder LoginModel
decodeLoginModel =
    Json.Decode.Pipeline.decode LoginModel
        |> Json.Decode.Pipeline.required "token" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "user" (decodeLoginModelUser)
        |> Json.Decode.Pipeline.optional "username" (Json.Decode.string) ""
        |> Json.Decode.Pipeline.optional "password" (Json.Decode.string) ""

decodeLoginModelUser : Json.Decode.Decoder SignedUser
decodeLoginModelUser =
    Json.Decode.Pipeline.decode SignedUser
        |> Json.Decode.Pipeline.required "username" (Json.Decode.string)

-- encode


encodeModel : LoginModel -> Json.Encode.Value
encodeModel loginModel =
    Json.Encode.object
        [ ("username",  Json.Encode.string <| loginModel.username)
        , ("password",  Json.Encode.string <| loginModel.password)
        ]