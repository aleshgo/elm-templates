module Messages exposing (..)


import Alert.Messages
import Http
import Time exposing (Time)
import Nav.Models exposing (Page)
import Navigation

type Msg
    = AlertMsg Alert.Messages.Msg
    -- Form
    | SetUsername String
    | SetPassword String
    | ToggleRemember
    | ClickSignUp
    | ClickLogIn
    | ClickLogOut
    | ClickTokenTest
    -- Effect
    | Tick Time
    -- Nav
    | GoToPage Page
    | UrlChange Navigation.Location
    -- I18n
    | SwitchLocale String
    -- Requests
    | UserRequest (Result Http.Error String)
    | TokenTestRequest (Result Http.Error String)
    --| TokenTestSuccess String
