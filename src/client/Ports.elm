port module Ports exposing (..)

import Models exposing (ModelStorage)


port saveModel : ModelStorage -> Cmd msg


port removeModel : String -> Cmd msg
