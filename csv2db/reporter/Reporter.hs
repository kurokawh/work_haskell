{-# LANGUAGE MonadComprehensions #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

import Database.Record

import Database.Relational.Query

import Database.HDBC (IConnection, SqlValue, rollback)
import Database.HDBC.Query.TH (makeRecordPersistableDefault)
import Database.HDBC.Record (runDelete, runInsert, runInsertQuery, runQuery, runUpdate)
import Database.HDBC.Session (withConnectionIO, handleSqlError')

import Data.Int (Int64)
import Data.Time (Day, LocalTime)

import qualified Account
import Account (Account, account, tableOfAccount)

import DataSource (connect)

import Prelude hiding (product)

allAccount :: Relation () Account
allAccount = relation $ query account



--
-- run and print sql
--

run :: (Show a, IConnection conn, FromSql SqlValue a, ToSql SqlValue p)
    => conn -> p -> Relation p a -> IO ()
run conn param rel = do
  putStrLn $ "SQL: " ++ show rel
  records <- runQuery conn (relationalQuery rel) param
  mapM_ print records
  putStrLn ""
  rollback conn

runI :: (IConnection conn, ToSql SqlValue p)
     => conn -> p -> Insert p -> IO ()
runI conn param ins = do
  putStrLn $ "SQL: " ++ show ins
  num <- runInsert conn ins param
  print num
  putStrLn ""
  rollback conn

runIQ :: (IConnection conn, ToSql SqlValue p)
     => conn -> p -> InsertQuery p -> IO ()
runIQ conn param ins = do
  putStrLn $ "SQL: " ++ show ins
  num <- runInsertQuery conn ins param
  print num
  putStrLn ""
  rollback conn

runU :: (IConnection conn, ToSql SqlValue p)
     => conn -> p -> Update p -> IO ()
runU conn param upd = do
  putStrLn $ "SQL: " ++ show upd
  num <- runUpdate conn upd param
  print num
  putStrLn ""
  rollback conn

runD :: (IConnection conn, ToSql SqlValue p)
     => conn -> p -> Delete p -> IO ()
runD conn param dlt = do
  putStrLn $ "SQL: " ++ show dlt
  num <- runDelete conn dlt param
  print num
  putStrLn ""
  rollback conn

main :: IO ()
main = handleSqlError' $ withConnectionIO (connect "x.db") $ \conn -> do
  run conn () allAccount
  putStrLn $ "SQL: " ++ show allAccount

