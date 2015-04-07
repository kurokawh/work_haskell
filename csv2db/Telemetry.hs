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
    , Telemetry_d12(..)
    , Telemetry_d12Id -- only for avoid warning
    , migrateAll_d12
    , convert_d12
    , Telemetry_d13(..)
    , Telemetry_d13Id -- only for avoid warning
    , migrateAll_d13
    , to_d13
    , Telemetry_d29(..)
    , Telemetry_d29Id -- only for avoid warning
    , migrateAll_d29
    , to_d29
    ) where

import Numeric
import Control.Applicative ((<*>), (<$>))
import Control.Monad.IO.Class (liftIO)
import qualified Data.Vector as V
import Data.Csv
import Database.Persist
import Database.Persist.TH
import Database.Persist.Sqlite (runMigration)
import Data.String (IsString)

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
    p20 String -- index: 48
    filename String -- store filename to avoid duplicated insertion.
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
                          (getval_or_empty v 48) <*>
                          (getval_or_empty v 100) -- TBD: fiename cannot be pased. store "" before conversion.


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
    filename String
    deriving Show Eq
|]
    
to_d12 :: String -> Telemetry -> Telemetry_d12
to_d12 f t = Telemetry_d12
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
           (f)

{-
is_parsed :: Control.Monad.IO.Class.MonadIO m =>
             String ->
             Control.Monad.Trans.Reader.ReaderT
                    Database.Persist.Sql.Types.SqlBackend
                    m
                    [Entity Telemetry]
-}
is_parsed f = selectList [TelemetryFilename ==. f] [LimitTo 1]

convert_d12 vlist = do
      runMigration migrateAll_d12
      let cvlist =  map (\(f, v) -> (f, V.map (to_d12 f) v)) vlist -- to store filename
      mapM_ (\(f, v) -> do
              found <- selectList [Telemetry_d12Filename ==. f] [LimitTo 1]
              liftIO (putStrLn ("\tlength: " ++ (show (length found))))
              if length found == 0
              then
                  V.mapM_ insert v
              else
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
                  -- do nothing
           ) cvlist


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
    hexInt Int -- test 1
    hexVal Int -- test 2
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
           (decstr_to_int $ telemetryP1 t)
           (hexstr_to_int $ telemetryP1 t)

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

