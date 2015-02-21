{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
import Data.Text (Text)
import qualified Data.Text as T
import Text.Hamlet (HtmlUrlI18n, ihamlet)
--import Text.Blaze (toHtml)
import Text.Blaze (toMarkup)
import Text.Blaze.Renderer.String (renderHtml)

data MyRoute = Home | Time | Stylesheet

renderUrl :: MyRoute -> [(Text, Text)] -> Text
renderUrl Home _ = "/home"
renderUrl Time _ = "/time"
renderUrl Stylesheet _ = "/style.css"

data Msg = Hello | Apples Int

renderJapanese :: Msg -> Text
renderJapanese Hello = "こんにちは"
renderJapanese (Apples 0) = "あなたはリンゴを買っていない"
renderJapanese (Apples i) = T.concat ["あなたは", T.pack $ show i, "個のリンゴを買った"]

template :: Int -> HtmlUrlI18n Msg MyRoute
template count = [ihamlet|
$doctype 5
<html>
    <head>
        <title>i18n
    <body>
        <h1>_{Hello}
        <p>_{Apples count}
|]

main :: IO ()
main = putStrLn $ renderHtml
--     $ (template 5) (toHtml . renderJapanese) renderUrl
     $ (template 5) (toMarkup . renderJapanese) renderUrl
--     $ (template 0) (toMarkup . renderJapanese) renderUrl
