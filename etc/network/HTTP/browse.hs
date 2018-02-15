import Network.HTTP
import Network.HTTP.Proxy (parseProxy)
import Network.Browser (browse, request, setProxy, request)
import Data.Maybe

main :: IO ()
main = do
  -- リクエストを送り、レスポンスを取得する。
  (uri, res) <- browse $ request $ getRequest "http://google.co.jp"
  -- レスポンスの表示
  putStr $ rspBody res

-- http://d.hatena.ne.jp/kenkov/20110430/1304162021
{--
上のプログラムで使っている主な関数の型は

Network.HTTP
  getRequest :: String -> Request_String
Network.HTTP.Base
  type Request_String = Request String
Network.Browser
  request :: HStream ty => Request ty -> BrowserAction (HandleStream ty) (URI, Response ty)
  browse :: BrowserAction conn a -> IO a
--}
