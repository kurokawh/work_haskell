{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs             #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeSynonymInstances       #-}
{-# LANGUAGE FlexibleInstances          #-}
module Telemetry
    ( Telemetry(..)
    , migrateAll
    ) where

import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative,
                            (<*>), (<$>), (<|>), (<*), (*>), empty, pure)
import qualified Data.Vector as V
import Data.Csv
import Database.Persist.TH

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Telemetry
    serverTime String -- Int? -- index: 0
    consoleType Int -- index: 3
    systemVer Int
    productCode Int
    productSubCode Int
    idu Int --Bool
    logConfVer String
    timestamp String -- Int?
    clockType Int
    uniqueId String -- index: 11
    p1 String -- index: 29
    p2 String
    p3 String
    p4 String
    p5 String
    p6 String
    p7 String
    p8 String
    p9 String
    p10 String
    p11 String
    p12 String
    p13 String
    p14 String
    p15 String
    p16 String
    p17 String
    p18 String
    p19 String
    p20 String
--    Primary serverTime
    deriving Show Eq
|]
    
instance FromRecord Telemetry where
    parseRecord v = Telemetry <$>
                          v .! 0 <*>
--                          v .! 1 <*>
--                          v .! 2 <*>
                          v .! 3 <*>
                          v .! 4 <*>
                          v .! 5 <*>
                          v .! 6 <*>
                          v .! 7 <*>
                          v .! 8 <*>
                          v .! 9 <*>
                          v .! 10 <*>
                          v .! 11 <*>
                          (getval_or_empty v 29) <*>
                          (getval_or_empty v 30) <*>
                          (getval_or_empty v 31) <*>
                          (getval_or_empty v 32) <*>
                          (getval_or_empty v 33) <*>
                          (getval_or_empty v 34) <*>
                          (getval_or_empty v 35) <*>
                          (getval_or_empty v 36) <*>
                          (getval_or_empty v 37) <*>
                          (getval_or_empty v 38) <*>
                          (getval_or_empty v 39) <*>
                          (getval_or_empty v 40) <*>
                          (getval_or_empty v 41) <*>
                          (getval_or_empty v 42) <*>
                          (getval_or_empty v 43) <*>
                          (getval_or_empty v 44) <*>
                          (getval_or_empty v 45) <*>
                          (getval_or_empty v 46) <*>
                          (getval_or_empty v 47) <*>
                          (getval_or_empty v 48)

-- return index val or return "" if index is too big.
--getval_or_empty :: Record -> Int -> String
getval_or_empty v i
    | i < V.length v = v .! i
    | otherwise      = return ""
