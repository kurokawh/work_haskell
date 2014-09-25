{-# LANGUAGE TemplateHaskell   #-}
module Gender where

import Database.Persist.TH

data Gender = Male | Female
    deriving (Show, Read, Eq)
derivePersistField "Gender"
