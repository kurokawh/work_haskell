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
    , Telemetry_d12(..)
    , migrateAll_d12
    , to_d12
    , Telemetry_d13(..)
    , migrateAll_d13
    , to_d13
    , Telemetry_d29(..)
    , migrateAll_d29
    , to_d29
    ) where

import Control.Monad (MonadPlus, mplus, mzero)
import Control.Applicative (Alternative, Applicative,
                            (<*>), (<$>), (<|>), (<*), (*>), empty, pure)
import qualified Data.Vector as V
import Data.Csv
import Database.Persist.TH

-- return index val or return "" if index is too big.
--getval_or_empty :: Record -> Int -> String
getval_or_empty v i
    | i < V.length v = v .! i
    | otherwise      = return ""



-- general schema
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

share [mkPersist sqlSettings, mkMigrate "migrateAll_d12"] [persistLowerCase|
Telemetry_d12
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
    xx1 String -- index: 29
    xx2 String
    xx3 String
    xx4 String
    xx5 String
    xx6 String
    xx7 String
    xx8 String
    xx9 String
    xx10 String
    xx11 String
    xx12 String
    xx13 String
    xx14 String
    xx15 String
    xx16 String
    xx17 String
    xx18 String
    xx19 String
    xx20 String
    deriving Show Eq
|]
    
to_d12 :: Telemetry -> Telemetry_d12
to_d12 t = Telemetry_d12
           (telemetryServerTime t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)
           (telemetryP1 t)
           (telemetryP2 t)
           (telemetryP3 t)
           (telemetryP4 t)
           (telemetryP5 t)
           (telemetryP6 t)
           (telemetryP7 t)
           (telemetryP8 t)
           (telemetryP9 t)
           (telemetryP10 t)
           (telemetryP11 t)
           (telemetryP12 t)
           (telemetryP13 t)
           (telemetryP14 t)
           (telemetryP15 t)
           (telemetryP16 t)
           (telemetryP17 t)
           (telemetryP18 t)
           (telemetryP19 t)
           (telemetryP20 t)

share [mkPersist sqlSettings, mkMigrate "migrateAll_d13"] [persistLowerCase|
Telemetry_d13
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
    deriving Show Eq
|]
    
to_d13 :: Telemetry -> Telemetry_d13
to_d13 t = Telemetry_d13
           (telemetryServerTime t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)

share [mkPersist sqlSettings, mkMigrate "migrateAll_d29"] [persistLowerCase|
Telemetry_d29
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
    deriving Show Eq
|]
    
to_d29 :: Telemetry -> Telemetry_d29
to_d29 t = Telemetry_d29
           (telemetryServerTime t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)

