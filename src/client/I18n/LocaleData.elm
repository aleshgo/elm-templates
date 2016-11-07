module I18n.LocaleData exposing (..)

import I18n.Models exposing (Locale(..), LocaleSet)


type TranslationId
    = LoginHeader
    | SignUpHeader
    | UsernameInput
    | PasswordInput
    | RememberCheckbox
    | LoginButton
    | SignUpButton
    | ToLoginButton
    | ToSignUpButton
    | Hello
    | LogOutButton
    | TokenTestButton
    | TokenIat
    | TokenExp
    | CurrentTime
    | TokenLeftTime
    | TokenValid
    | LocaleText
    | TokenTestResult
    | Successful
    | Unsuccessful


translate : Locale -> TranslationId -> String
translate locale id =
    let
        localeSet =
            case id of
                LoginHeader ->
                    LocaleSet "Log In" "Вход"

                SignUpHeader ->
                    LocaleSet "Sign Up" "Создание"

                UsernameInput ->
                    LocaleSet "Username" "Имя пользователя"

                PasswordInput ->
                    LocaleSet "Password" "Пароль"

                RememberCheckbox ->
                    LocaleSet "Remeber a token" "Запомнить"

                LoginButton ->
                    LocaleSet "Login" "Зайти"

                SignUpButton ->
                    LocaleSet "Create" "Создать"

                ToLoginButton ->
                    LocaleSet "Log in to your account" "Войти в учетку"

                ToSignUpButton ->
                    LocaleSet "Create an account" "Создать учетку"

                Hello ->
                    LocaleSet "Hello: " "Привет: "

                LogOutButton ->
                    LocaleSet "LogOut" "Выйти"

                TokenTestButton ->
                    LocaleSet "Token Test" "Тест токена"

                TokenIat ->
                    LocaleSet "Token iat: " "Время выпуска токена: "

                TokenExp ->
                    LocaleSet "Token exp: " "Время истечения токена: "

                CurrentTime ->
                    LocaleSet "Current time: " "Текущее время: "

                TokenLeftTime ->
                    LocaleSet "Token Left Time, sec: " "Оставшееся время действия токена, сек: "

                TokenValid ->
                    LocaleSet "Token Valid: " "Токен действителен: "

                LocaleText ->
                    LocaleSet "Locale: " "Язык: "

                TokenTestResult ->
                    LocaleSet "Token test result: " "Результат тестирования токена: "

                Successful ->
                    LocaleSet "Successful " "Уcпешный"

                Unsuccessful ->
                    LocaleSet "Unsuccessful " "Провалился"
    in
        case locale of
            En ->
                .en localeSet

            Ru ->
                .ru localeSet
