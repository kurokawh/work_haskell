module Handler.MultiPost where

import Import

--postMultiPostR :: Handler Html
--postMultiPostR = error "Not yet implemented: postMultiPostR"
postMultiPostR :: Handler ()
postMultiPostR = do
    posts <- requireJsonBody :: Handler [Post]
    _    <- runDB $ mapM insert posts  -- insert list records at once

    sendResponseStatus status201 ("CREATED" :: Text)
