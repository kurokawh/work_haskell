module Handler.Comment where

import Import
import Helpers.Comment

{-
postCommentR :: Handler Value
postCommentR = do
    -- requireJsonBody will parse the request body into the appropriate type, or return a 400 status code if the request JSON is invalid.
    -- (The ToJSON and FromJSON instances are derived in the config/models file).
    comment <- (requireJsonBody :: Handler Comment)

    -- The YesodAuth instance in Foundation.hs defines the UserId to be the type used for authentication.
    maybeCurrentUserId <- maybeAuthId
    let comment' = comment { commentUserId = maybeCurrentUserId }

    insertedComment <- runDB $ insertEntity comment'
    returnJson insertedComment
-}

getCommentR :: PostId -> CommentId -> Handler Value
getCommentR _ cid = do
    comment <- runDB $ get404 cid

    return $ object ["comment" .= (Entity cid comment)]

-- We'll talk about this later
--putCommentR :: PostId -> CommentId -> Handler ()
putCommentR :: PostId -> CommentId -> Handler ()
putCommentR pid cid = do
    runDB . replace cid . toComment pid =<< requireJsonBody

    sendResponseStatus status200 ("UPDATED" :: Text)

deleteCommentR :: PostId -> CommentId -> Handler ()
deleteCommentR _ cid = do
    runDB $ delete cid

    sendResponseStatus status200 ("DELETED" :: Text)

