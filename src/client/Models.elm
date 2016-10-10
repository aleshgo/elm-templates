module Models exposing (..)

import Nav.Models exposing (Page(..))


type alias Model =
    { page : Page
    , pageId : Int
    }


initialModel : Model
initialModel =
    { page = Home
    , pageId = 0
    }
