module Models exposing (..)

import Nav.Models exposing (Page(..))
import Login.Models exposing (LoginModel, SignedUser)

type alias Model =
    { page : Page
    , pageId : Int
    , login: Login.Models.LoginModel
    }

initialModel : Model
initialModel =
    { page = Home
    , pageId = 0
    , login = LoginModel "" ( SignedUser "" ) "" ""
    }
