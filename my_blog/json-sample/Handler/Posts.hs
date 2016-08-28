module Handler.Posts where

import Import

{--
getPostsR :: Handler Html
getPostsR = error "Not yet implemented: getPostsR"

postPostsR :: Handler Html
postPostsR = error "Not yet implemented: postPostsR"
--}

getPostsR :: Handler Value
getPostsR = do
    posts <- runDB $ selectList [] [] :: Handler [Entity Post]
    return $ object ["posts" .= posts]

postPostsR :: Handler ()
postPostsR = do
    post <- requireJsonBody :: Handler Post
    _    <- runDB $ insert post
    sendResponseStatus status201 ("CREATED" :: Text)
