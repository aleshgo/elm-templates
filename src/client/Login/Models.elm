module Login.Models exposing (LoginModel, SignedUser)

type alias SignedUser =
    { username : String
    }

type alias LoginModel =
    { token : String
    , user : SignedUser
    , username: String
    , password: String
    }
