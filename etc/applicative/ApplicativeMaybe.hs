module ApplicativeMaybe
where

-- http://naotoogawa.hatenablog.jp/entry/2018/05/14/Applicative_Mabye%E3%81%A7%E6%9D%A1%E4%BB%B6%E5%88%86%E5%B2%90
-- ghci ApplicativeMaybe.hs

import qualified Data.HashMap.Lazy as HML
import Control.Applicative ((<|>))

m = HML.fromList [("k1", "**"), ("k2", "##")]

foo x1 x2 = 
  case HML.lookup x1 m of
    Just a1  -> Just a1
    Nothing ->  
      case HML.lookup x2 m of
        Just a2 -> Just a2
        Nothing -> Nothing



foo'' x1 x2 = HML.lookup x1 m <|> HML.lookup x2 m
