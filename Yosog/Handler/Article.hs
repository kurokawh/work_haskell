module Handler.Article where

import Import

-- The get404 function tries to do a get on the DB. 
-- If it fails, it returns a 404 page. 
getArticleR :: ArticleId -> Handler Html
getArticleR articleId = do
    article <- runDB $ get404 articleId
    defaultLayout $ do
        setTitle $ toHtml $ articleTitle article
        $(widgetFile "article")
