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
module DbRecord
    ( DbRecord(..)
    , DbRecordId     -- only for avoid warning
    , migrateAll
    , insert_rec
    , DbRecord_s2(..)
    , DbRecord_s2Id -- only for avoid warning
    , migrateAll_s2
    , insert_s2
    , DbRecord_s3(..)
    , DbRecord_s3Id -- only for avoid warning
    , migrateAll_s3
    , insert_s3
    ) where

import Control.Applicative ((<*>), (<$>))
import Control.Monad.IO.Class (liftIO, MonadIO)
import Control.Monad.Trans.Reader  (ReaderT)
import qualified Data.Vector as V
import Data.Csv
import Data.String (IsString)
import Data.ByteString.Char8 (pack, unpack)
import Database.Persist
import Database.Persist.TH
import Database.Persist.Sqlite (SqlBackend)
import Network.HTTP.Types.URI (urlDecode)
import FileToVec


-- return index val or return "" if index is too big.
getval_or_empty :: (FromField a, Data.String.IsString a) =>
                   V.Vector Field -> Int -> Parser a
getval_or_empty v i
    | i < V.length v = v .! i
    | otherwise      = return ""

{-
decstr_to_int :: String -> Int
decstr_to_int decstr = read decstr :: Int

hexstr_to_int :: String -> Int
hexstr_to_int hexstr = x
    where [(x,_)] = readHex hexstr

enum_to_str :: [String] -> Int -> String
enum_to_str list idx
    | idx < (length list) && idx >= 0 = list !! idx
    | otherwise = show idx
-}

-- for qaf & samplingRate
recstr_to_int :: String -> Int
recstr_to_int "" = 0
recstr_to_int s = read s :: Int

url_decode :: String -> String
url_decode = unpack.(urlDecode False).pack

-- general schema
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
DbRecord
    filename String -- store filename to avoid duplicated insertion.
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
    
instance FromRecord DbRecord where
    parseRecord v = DbRecord <$>
                          (getval_or_empty v 100) <*> -- filename cannot be pased here. store ""
                          (getval_or_empty v 0) <*>
                          (getval_or_empty v 1) <*>
                          (getval_or_empty v 2) <*>
                          (getval_or_empty v 3) <*>
                          (getval_or_empty v 4) <*>
                          (getval_or_empty v 5) <*>
                          (getval_or_empty v 6) <*>
                          (getval_or_empty v 7) <*>
                          (getval_or_empty v 8) <*>
                          (getval_or_empty v 9) <*>
                          (getval_or_empty v 10) <*>
                          (getval_or_empty v 11) <*>
                          (getval_or_empty v 12) <*> -- qaf (optional)
                          (getval_or_empty v 13) <*> -- sampling rate
                          (getval_or_empty v 14) <*>
                          (getval_or_empty v 15) <*>
                          (getval_or_empty v 16) <*>
                          (getval_or_empty v 17) <*>
                          (getval_or_empty v 18) <*>
                          (getval_or_empty v 19)

to_rec :: String -> DbRecord -> DbRecord
to_rec f t = DbRecord
           (f)
           (url_decode $ dbRecordP1 t)
           (url_decode $ dbRecordP2 t)
           (url_decode $ dbRecordP3 t)
           (url_decode $ dbRecordP4 t)
           (url_decode $ dbRecordP5 t)
           (url_decode $ dbRecordP6 t)
           (url_decode $ dbRecordP7 t)
           (url_decode $ dbRecordP8 t)
           (url_decode $ dbRecordP9 t)
           (url_decode $ dbRecordP10 t)
           (url_decode $ dbRecordP11 t)
           (url_decode $ dbRecordP12 t)
           (url_decode $ dbRecordP13 t)
           (url_decode $ dbRecordP14 t)
           (url_decode $ dbRecordP15 t)
           (url_decode $ dbRecordP16 t)
           (url_decode $ dbRecordP17 t)
           (url_decode $ dbRecordP18 t)
           (url_decode $ dbRecordP19 t)
           (url_decode $ dbRecordP20 t)


share [mkPersist sqlSettings, mkMigrate "migrateAll_s2"] [persistLowerCase|
DbRecord_s2
    filename String -- store filename to avoid duplicated insertion.
    contry String
    region String
    age Int
    name String
    deriving Show Eq
|]
    
to_s2 :: String -> DbRecord -> DbRecord_s2
to_s2 f t = DbRecord_s2
           (f)
           (dbRecordP1 t)
           (dbRecordP2 t)
           (recstr_to_int $ dbRecordP3 t)
           (dbRecordP4 t)
 

share [mkPersist sqlSettings, mkMigrate "migrateAll_s3"] [persistLowerCase|
DbRecord_s3
    filename String -- store filename to avoid duplicated insertion.
    contry String
    name String
    deriving Show Eq
|]
    
to_s3 :: String -> DbRecord -> DbRecord_s3
to_s3 f t = DbRecord_s3
           (f)
           (dbRecordP1 t)
           (dbRecordP2 t)



insert_s2 :: Control.Monad.IO.Class.MonadIO m =>
             FilePath
             -> Control.Monad.Trans.Reader.ReaderT SqlBackend m ()
insert_s2 f = do
              let fn = file_to_filename f
              found <- selectList [DbRecord_s2Filename ==. fn] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  v <- liftIO $ file_to_vec f
                  let cv = V.map (to_s2 fn) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
insert_s3 :: Control.Monad.IO.Class.MonadIO m =>
             FilePath
             -> Control.Monad.Trans.Reader.ReaderT SqlBackend m ()
insert_s3 f = do
              let fn = file_to_filename f
              found <- selectList [DbRecord_s3Filename ==. fn] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  v <- liftIO $ file_to_vec f
                  let cv = V.map (to_s3 fn) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
insert_rec :: Control.Monad.IO.Class.MonadIO m =>
             FilePath
             -> Control.Monad.Trans.Reader.ReaderT SqlBackend m ()
insert_rec f = do
              let fn = file_to_filename f
              found <- selectList [DbRecordFilename ==. fn] [LimitTo 1]
              if length found == 0
              then do
                  -- not parsed yet
                  v <- liftIO $ file_to_vec f
                  let cv = V.map (to_rec fn) v
                  V.mapM_ insert cv
              else
                  -- already parsed: do nothing
                  liftIO (putStrLn ("\tskip because already parsed: " ++ f))
