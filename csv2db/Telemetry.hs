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
    , TelemetryId     -- only for avoid warning
    , migrateAll
    , insert_tel
    , Telemetry_d12(..)
    , Telemetry_d12Id -- only for avoid warning
    , migrateAll_d12
    , insert_d12
    , Telemetry_d13(..)
    , Telemetry_d13Id -- only for avoid warning
    , migrateAll_d13
    , insert_d13
    , Telemetry_d29(..)
    , Telemetry_d29Id -- only for avoid warning
    , migrateAll_d29
    , insert_d29
    ) where

import Numeric
import Control.Applicative ((<*>), (<$>))
import Control.Monad.IO.Class (liftIO)
import qualified Data.Vector as V
import Data.Csv
import Data.String (IsString)
import Data.ByteString.Char8 (pack, unpack)
import Database.Persist
import Database.Persist.TH
import Network.HTTP.Types.URI (urlDecode)

-- return index val or return "" if index is too big.
getval_or_empty :: (FromField a, Data.String.IsString a) =>
                   V.Vector Field -> Int -> Parser a
getval_or_empty v i
    | i < V.length v = v .! i
    | otherwise      = return ""

decstr_to_int :: String -> Int
decstr_to_int decstr = read decstr :: Int

hexstr_to_int :: String -> Int
hexstr_to_int hexstr = x
    where [(x,_)] = readHex hexstr

-- for qaf & samplingRate
telstr_to_int :: String -> Int
telstr_to_int "" = 0
telstr_to_int s = read s :: Int

url_decode :: String -> String
url_decode = unpack.(urlDecode False).pack

enum_to_str :: [String] -> Int -> String
enum_to_str list idx
    | idx < (length list) && idx >= 0 = list !! idx
    | otherwise = show idx

-- general schema
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Telemetry
    filename String -- store filename to avoid duplicated insertion.
    serverTime Int -- index: 0
    contry String
    region String
    consoleType Int -- index: 3
    systemVer String
    productCode Int
    productSubCode Int
    idu Int --Bool
    logConfVer String
    timestamp Int
    clockType Int
    uniqueId String -- index: 11
    qaf String
    samplingRate String -- index: 13
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
    p20 String -- index: 48
--    Primary serverTime
    deriving Show Eq
|]
    
instance FromRecord Telemetry where
    parseRecord v = Telemetry <$>
                          (getval_or_empty v 100) <*> -- filename cannot be pased here. store ""
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
                          (getval_or_empty v 12) <*> -- qaf (optional)
                          (getval_or_empty v 13) <*> -- sampling rate
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

to_tel :: String -> Telemetry -> Telemetry
to_tel f t = Telemetry
           (f)
           (telemetryServerTime t)
           (telemetryContry t)
           (telemetryRegion t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)
           (telemetryQaf t)
           (telemetrySamplingRate t)
           -- pX
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


share [mkPersist sqlSettings, mkMigrate "migrateAll_d12"] [persistLowerCase|
Telemetry_d12
    filename String -- store filename to avoid duplicated insertion.
    serverTime Int -- index: 0
    contry String
    region String
    consoleType Int -- index: 3
    systemVer String
    productCode Int
    productSubCode Int
    idu Int --Bool
    logConfVer String
    timestamp Int
    clockType Int
    uniqueId String -- index: 11
    qaf Int
    samplingRate Int -- index: 13
    bootTrigger String -- TBD: prepare BootTrigger type -- index: 29 (p1)
    dbFile String
    dbProcess Int
    dbOperation Int
    corruptReason Int
    estimatedTime Int
    actualTime Int
    prevSystemVer String -- index: 36 (p8)
    deriving Show Eq
|]
    
to_d12 :: String -> Telemetry -> Telemetry_d12
to_d12 f t = Telemetry_d12
           (f)
           (telemetryServerTime t)
           (telemetryContry t)
           (telemetryRegion t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)
           (telstr_to_int $ telemetryQaf t)
           (telstr_to_int $ telemetrySamplingRate t)
           -- pX
           (enum_to_str ["Unknown", "SystemUpdate", "AutoUpdate", "InitialSetup", "SafeMode", "Corruption"] $ decstr_to_int $ telemetryP1 t) -- boot trigger
           (url_decode $ telemetryP2 t) -- db file path
           (decstr_to_int $ telemetryP3 t) -- db process index
           (decstr_to_int $ telemetryP4 t) -- db operation index
           (decstr_to_int $ telemetryP5 t) -- corrupt reason
           (hexstr_to_int $ telemetryP6 t) -- estimated time
           (hexstr_to_int $ telemetryP7 t) -- actual time
           (telemetryP8 t) -- prev system ver
 

share [mkPersist sqlSettings, mkMigrate "migrateAll_d13"] [persistLowerCase|
Telemetry_d13
    filename String -- store filename to avoid duplicated insertion.
    serverTime Int -- index: 0
    contry String
    region String
    consoleType Int -- index: 3
    systemVer String
    productCode Int
    productSubCode Int
    idu Int --Bool
    logConfVer String
    timestamp Int
    clockType Int
    uniqueId String -- index: 11
    qaf Int
    samplingRate Int -- index: 13
    storageSize Int -- (p1)
    availableSize Int
    manufacture String
    product String
    mountResult Int
    filesystem String -- TBD: prepare Filesystem type.
    numOfUsb Int
    numOfPartition Int -- (p8)
    deriving Show Eq
|]
    
to_d13 :: String -> Telemetry -> Telemetry_d13
to_d13 f t = Telemetry_d13
           (f)
           (telemetryServerTime t)
           (telemetryContry t)
           (telemetryRegion t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)
           (telstr_to_int $ telemetryQaf t)
           (telstr_to_int $ telemetrySamplingRate t)
           -- pX
           (hexstr_to_int $ telemetryP1 t) -- storage size
           (hexstr_to_int $ telemetryP2 t) -- available size
           (url_decode $ telemetryP3 t) -- manufacture
           (url_decode $ telemetryP4 t) -- product
           (hexstr_to_int $ telemetryP5 t) -- mount result
           (enum_to_str ["Unknown", "FAT32", "exFAT", "NTFS", "UFS"] $ hexstr_to_int $ telemetryP6 t) -- filesystem
           (hexstr_to_int $ telemetryP7 t) -- num of attached USB mass
           (hexstr_to_int $ telemetryP8 t) -- num of partition

share [mkPersist sqlSettings, mkMigrate "migrateAll_d29"] [persistLowerCase|
Telemetry_d29
    filename String -- store filename to avoid duplicated insertion.
    serverTime Int -- index: 0
    contry String
    region String
    consoleType Int -- index: 3
    systemVer String
    productCode Int
    productSubCode Int
    idu Int --Bool
    logConfVer String
    timestamp Int
    clockType Int
    uniqueId String -- index: 11
    qaf Int
    samplingRate Int -- index: 13
    dbfileSize Int -- p1
    numOfTitles Int
    numOfPhotos Int
    numOfTrophyPhotos Int
    numOfShareTagPhotos Int
    numOfVideos Int -- p6
    numOfTrophyVideos Int
    numOfShareTagVideos Int
    numOfShareTags Int
    numOfCommonTag Int
    numOfDmTag Int -- p11
    numOfYtTag Int
    numOfTwtTag Int -- p13
    deriving Show Eq
|]
    
to_d29 :: String -> Telemetry -> Telemetry_d29
to_d29 f t = Telemetry_d29
           (f)
           (telemetryServerTime t)
           (telemetryContry t)
           (telemetryRegion t)
           (telemetryConsoleType t)
           (telemetrySystemVer t)
           (telemetryProductCode t)
           (telemetryProductSubCode t)
           (telemetryIdu t)
           (telemetryLogConfVer t)
           (telemetryTimestamp t)
           (telemetryClockType t)
           (telemetryUniqueId t)
           (telstr_to_int $ telemetryQaf t)
           (telstr_to_int $ telemetrySamplingRate t)
           -- pX
           (hexstr_to_int $ telemetryP1 t)
           (hexstr_to_int $ telemetryP2 t)
           (hexstr_to_int $ telemetryP3 t)
           (hexstr_to_int $ telemetryP4 t)
           (hexstr_to_int $ telemetryP5 t)
           (hexstr_to_int $ telemetryP6 t)
           (hexstr_to_int $ telemetryP7 t)
           (hexstr_to_int $ telemetryP8 t)
           (hexstr_to_int $ telemetryP9 t)
           (hexstr_to_int $ telemetryP10 t)
           (hexstr_to_int $ telemetryP11 t)
           (hexstr_to_int $ telemetryP12 t)
           (hexstr_to_int $ telemetryP13 t)



{-
insert_d12 :: Control.Monad.IO.Class.MonadIO m =>
        (String, V.Vector Telemetry)
            -> Control.Monad.Trans.Reader.ReaderT Database.Persist.Sql.Types.SqlBackend m ()
-}
insert_d12 (f, v) = do
              found <- selectList [Telemetry_d12Filename ==. f] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  let cv = V.map (to_d12 f) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
insert_d13 (f, v) = do
              found <- selectList [Telemetry_d13Filename ==. f] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  let cv = V.map (to_d13 f) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
insert_d29 (f, v) = do
              found <- selectList [Telemetry_d29Filename ==. f] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  let cv = V.map (to_d29 f) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
insert_tel (f, v) = do
              found <- selectList [TelemetryFilename ==. f] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  let cv = V.map (to_tel f) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
