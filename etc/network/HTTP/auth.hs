import Network.HTTP
import Network.Browser


main =
  browse $ do
    setAuthorityGen (\_ _ -> return $ Just ("username", "password"))
    request $ getRequest "http://github.com"

-- http://justus.science/blog/2015/07/30/basic-auth-haskell.html
