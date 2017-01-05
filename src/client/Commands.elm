module Commands exposing (..)

import Models exposing (Model)
import Task exposing (Task)
import Http
import Messages exposing (Msg(..))
import Json.Decode as Decode exposing (Decoder, field)
import Json.Encode as Encode


-- Urls


tokenTestUrl : String
tokenTestUrl =
    "api/sessions/test"


signupUrl : String
signupUrl =
    "api/users"


loginUrl : String
loginUrl =
    "api/sessions/create"



-- Encoders / Decoders


userEncoder : Model -> Encode.Value
userEncoder model =
    Encode.object
        [ ( "username", Encode.string model.username )
        , ( "password", Encode.string model.password )
        ]


tokenDecoder : Decoder String
tokenDecoder =
    field "token" Decode.string



-- POST signup / login request

postUser : Model -> String -> Http.Request String
postUser model url =
    Http.request
        { method = "POST"
        , headers = []
        , timeout = Nothing
        , withCredentials = False
        , url = url
        , body = userEncoder model |> Http.jsonBody
        , expect = Http.expectJson tokenDecoder
        }


postUserRequest : Model -> String -> Cmd Msg
postUserRequest model url =
    postUser model url
        |> Http.send UserRequest


tokenTest : Model -> Http.Request String
tokenTest model =
    Http.request
        { method = "GET"
        , headers = [ Http.header "token" (model.token |> Maybe.withDefault "") ]
        , timeout = Nothing
        , withCredentials = False
        , url = tokenTestUrl
        , body =  Http.emptyBody
        , expect = Http.expectJson tokenDecoder
        }

tokenTestRequest : Model -> Cmd Msg
tokenTestRequest model =
 tokenTest model
     |> Http.send TokenTestRequest