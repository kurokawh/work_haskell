module Handler.Comments where

import Import
import Helpers.Comment

getCommentsR :: PostId -> Handler Value
getCommentsR pid = do
    comments <- runDB $ selectList [CommentPost ==. pid] []

    --return $ object ["comments" .= comments]
    return $ array comments -- remove "comments" header.


postCommentsR :: PostId -> Handler ()
postCommentsR pid = do
    _ <- runDB . insert . toComment pid =<< requireJsonBody

    sendResponseStatus status201 ("CREATED" :: Text)
