module Handler.Filter where

import Import

{--
getFilterR :: Text -> Handler Html
getFilterR sender = error "Not yet implemented: getFilterR"
--}

getFilterR :: Text -> Handler Value
getFilterR sender = do
    posts <- runDB $ selectList [PostSender ==. sender] [] :: Handler [Entity Post]
    return $ object ["posts" .= posts]
