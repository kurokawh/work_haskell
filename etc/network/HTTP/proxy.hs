import Network.HTTP
import Network.HTTP.Proxy (parseProxy)
import Network.Browser (browse, request, setProxy, request)
import Data.Maybe

main :: IO ()
main = do
  (uri, res) <- browse $ do
         -- プロキシを設定してリクエストを送る
         setProxy . fromJust $ parseProxy "proxy.server:8080"
         request $ getRequest "http://google.co.jp"
  putStr $ rspBody res


-- http://d.hatena.ne.jp/kenkov/20110430/1304162021
{--
プロキシ関連の関数の型は次のようになります。
Network.HTTP.Proxy
  parseProxy :: String -> Maybe Proxy
Network.HTTP.Base
  setProxy :: Proxy -> BrowserAction t ()
--}
