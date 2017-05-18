{-# LANGUAGE OverloadedStrings #-}
import Prelude hiding (readFile)
import Text.XML
import Text.XML.Cursor
import qualified Data.Text as T

main :: IO ()
main = do
    doc <- readFile def "test.xml"
    let cursor = fromDocument doc
    print $ T.concat $
            child cursor >>= element "head" >>= child
                         >>= element "title" >>= descendant >>= content
                         
{-
WORK!!!
*Main> print $ T.concat $ child c1 >>= element (Name (T.pack "param") Nothing Nothing) >>= child >>= content


NOT WORK: "" is returned
*Main> print $ T.concat $ child c1 >>= attributeIs (Name (T.pack "key") Nothing Nothing) (T.pack "APP_VER") >>= content
""
-}

