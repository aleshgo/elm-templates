module Messages exposing (Msg(..))

import Login.Messages

type Msg
    = GoHomePage
    | UsersList
    | LoginPage
    | GoToPage Int
    | LogOut
    | LoginMsg Login.Messages.Msg
