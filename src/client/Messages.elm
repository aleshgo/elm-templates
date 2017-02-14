module Messages exposing (..)

import Navigation


type Msg
    = GoHomePage
    | GoToPage Int
    | UrlChange Navigation.Location
