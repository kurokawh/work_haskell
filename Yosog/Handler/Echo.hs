module Handler.Echo where

import Import

getEchoR :: Text -> Handler Html
--getEchoR = error "Not yet implemented: getEchoR"
getEchoR theText = defaultLayout $(widgetFile "echo")
