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
    serverTime String -- Int?
    consoleType Int
    systemVer Int
    productCode Int
    productSubCode Int
    idu Int --Bool
    logConfVer String
    timestamp String -- Int?
    clockType Int
    uniqueId String
    p1 String
    p2 String
    p3 String
    p4 String
    p5 String
    p6 String
    p7 String
    p8 String
    p9 String
    p10 String
--    Primary serverTime
    deriving Show Eq
|]
    
instance FromRecord Telemetry where
    parseRecord v = Telemetry <$>
                          v .! 0 <*>
                          v .! 1 <*>
                          v .! 2 <*>
                          v .! 3 <*>
                          v .! 4 <*>
                          v .! 5 <*>
                          v .! 6 <*>
                          v .! 7 <*>
                          v .! 8 <*>
                          v .! 9 <*>
                          v .! 10 <*>
                          v .! 11 <*>
                          v .! 12 <*>
                          v .! 13 <*>
                          v .! 14 <*>
                          v .! 15 <*>
                          v .! 16 <*>
                          v .! 17 <*>
                          v .! 18 <*>
                          v .! 19

