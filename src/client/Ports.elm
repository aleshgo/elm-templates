port module Ports exposing (..)


port loadBrowserLocale : (String -> msg) -> Sub msg


port saveBrowserLocale : String -> Cmd msg
