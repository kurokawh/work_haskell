{-# LANGUAGE DeriveGeneric #-}

module Handler.Home where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Text.Julius (RawJS (..))

-- Define our data that will be used for creating the form.
data FileForm = FileForm
    { fileInfo :: FileInfo
    , fileDescription :: Text
    }

data Sex = Male | Female
    deriving (Show, Generic)
data Person = Person
    { name :: Text
    , age  :: Int
    , sex  :: Sex
    }
    deriving (Show, Generic)

instance ToJSON Sex 
instance ToJSON Person 


samplePersonList :: [Person]
samplePersonList = [ (Person "Taro Yamada" 18 Male)
                   , (Person "Hanako Yamada" 25 Female)
                   , (Person "Ichiro Suzuki" 41 Male) ]

class ToCSV a where
  toCsv :: a -> Text
instance ToCSV Person where
  toCsv p = (name p) 
           ++ ("," :: Text) 
           ++ (pack $ show $ age p) 
           ++ ("," :: Text) 
           ++ (pack $ show $ sex p) 
           ++ ("\n" :: Text)
instance (ToCSV a) => ToCSV [a] where
  toCsv [] = ""
  toCsv (x:xs) = (toCsv x) ++ (toCsv xs)

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler TypedContent
getHomeR = selectRep $ do
    provideRep $ withUrlRenderer [hamlet|
                                         <table border>
                                             <tr>
                                               <th>name
                                               <th>age
                                               <th>sex
                                           $forall person <- samplePersonList
                                             <tr>
                                               <td>#{name person}
                                               <td>#{age person}
                                               <td>#{show $ sex person}
                                 |]
    provideJson $ samplePersonList
    provideRepType "text/plain" (return $ show samplePersonList)
    provideRepType "text/csv" (return $ toCsv samplePersonList)
--    provideRep (return $ toJSON person)  -- JSON : OK
--    provideRep (return $ name person) -- Text : OK
--    provideRepType "text/plain" (return $ repPlain $ name person) -- OK: Text
--    provideRepType "text/plain" (return $ name person) -- OK: Text
--    provideRepType "text/csv" (return $ name person) -- OK: Text
--    provideRepType "text/csv" (return $ toCsv person)
--  where
--    person = Person "Taro Yamada" 18


postHomeR :: Handler Html
postHomeR = do
    ((result, formWidget), formEnctype) <- runFormPost sampleForm
    let handlerName = "postHomeR" :: Text
        submission = case result of
            FormSuccess res -> Just res
            _ -> Nothing

    defaultLayout $ do
        let (commentFormId, commentTextareaId, commentListId) = commentIds
        aDomId <- newIdent
        setTitle "Welcome To Yesod!"
        $(widgetFile "homepage")

sampleForm :: Form FileForm
sampleForm = renderBootstrap3 BootstrapBasicForm $ FileForm
    <$> fileAFormReq "Choose a file"
    <*> areq textField textSettings Nothing
    -- Add attributes like the placeholder and CSS classes.
    where textSettings = FieldSettings
            { fsLabel = "What's on the file?"
            , fsTooltip = Nothing
            , fsId = Nothing
            , fsName = Nothing
            , fsAttrs =
                [ ("class", "form-control")
                , ("placeholder", "File description")
                ]
            }

commentIds :: (Text, Text, Text)
commentIds = ("js-commentForm", "js-createCommentTextarea", "js-commentList")
