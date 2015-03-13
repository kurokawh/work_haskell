{-# LANGUAGE GADTs             #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Telemetry
    ( Telemetry(..)
    , migrateAll
    ) where

import Database.Persist.TH

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Telemetry
    serverTime String -- Int?
    consoleType Int
    systemVer Int
    productCode Int
    productSubCode Int
    idu Bool
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
    Primary serverTime
    deriving Show Eq
|]
    
