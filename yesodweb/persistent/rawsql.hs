{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
import Database.Persist.TH
import Data.Text (Text)
import Database.Persist.Sqlite
import Control.Monad.IO.Class (liftIO, MonadIO)
import Control.Monad (forM_)
import Control.Monad.Trans.Reader (ReaderT)
import Data.Conduit
import qualified Data.Conduit.List as CL

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name Text
    deriving Show
|]

selectPersons :: (Control.Monad.IO.Class.MonadIO m) =>
                 Control.Monad.Trans.Reader.ReaderT SqlBackend m [Entity Person]
selectPersons = rawSql "SELECT ?? FROM Person WHERE name LIKE '%Snoyman'" []

main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll
    insert $ Person "Michael Snoyman"
    insert $ Person "Miriam Snoyman"
    insert $ Person "Eliezer Snoyman"
    insert $ Person "Gavriella Snoyman"
    insert $ Person "Greg Weber"
    insert $ Person "Rick Richardson"

    -- Persistent does not provide the LIKE keyword, but we'd like to get the
    -- whole Snoyman family...
    liftIO $ putStrLn "*** call rawQuery ***"
    let sql = "SELECT name FROM Person WHERE name LIKE '%Snoyman'"
    rawQuery sql [] $$ CL.mapM_ (liftIO . print)

    liftIO $ putStrLn "*** call rawSql ***"
    x <- selectPersons
    --liftIO $ print x
    liftIO $ forM_ x print
    return ()

