{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
import           Data.Default           (def)
import           Data.Text
--import           Network.HTTP.Conduit   (Manager, newManager)
import           Network.HTTP.Conduit   (Manager, conduitManagerSettings, newManager)
import qualified Facebook as FB
import           Yesod
import           Yesod.Auth
import           Yesod.Facebook (YesodFacebook(..))
import           Yesod.Auth.Facebook.ServerSide

data App = App
    { httpManager :: Manager
    }

mkYesod "App" [parseRoutes|
/ HomeR GET
/auth AuthR Auth getAuth
|]

instance Yesod App where
    approot = ApprootStatic "http://localhost:3000"
--    approot = ApprootStatic "http://test.local.jp:3000"

instance YesodAuth App where
    type AuthId App = Text
    getAuthId = return . Just . credsIdent

    loginDest _ = HomeR
    logoutDest _ = HomeR

    authPlugins _ =
        [ authFacebook ["email"]
        ]

    authHttpManager = httpManager

    maybeAuthId = lookupSession "_ID"

instance YesodFacebook App where
--    fbCredentials _ = FB.Credentials "<my app>" "<my app id>" "<my secret>"
    fbCredentials _ = FB.Credentials "Yesod FB Auth Sample" "620098198068547" "b1214edf3187635cedb7d5edcd28834c"
    fbHttpManager = httpManager

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

getHomeR :: Handler Html
getHomeR = do
    maid <- maybeAuthId
    defaultLayout
        [whamlet|
            <p>Your current auth ID: #{show maid}
            $maybe _ <- maid
                <p>
                    <a href=@{AuthR LogoutR}>Logout
            $nothing
                <p>
                    <a href=@{AuthR LoginR}>Go to the login page

        |]

main :: IO ()
main = do
    man <- newManager conduitManagerSettings
    warp 3000 $ App man
