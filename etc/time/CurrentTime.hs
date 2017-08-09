{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Monad.IO.Class     (liftIO)
import qualified Data.ByteString.Lazy.Char8 as L
import           Data.Time
import           Network                    (withSocketsDo)
import           Network.HTTP.Conduit


createRequestData today = [("index:brKursneListe",""),
 ("index:year","2016"),
 ("index:inputCalendar1", today),
 ("index:vrsta","3"),
 ("index:prikaz","0"),
 ("index:buttonShow","Prikazi")]


timeFromString  s = parseTimeOrError True defaultTimeLocale "%d %b %Y %l:%M %p" s

formatDateString time = formatTime defaultTimeLocale "%m/%d/%Y" time

getDateString = getCurrentTime

getFormatedDate  = formatDateString $ timeFromString getDateString
--getFormatedDate  = getDateString >= formatDateString $ timeFromString
--getFormatedDate = do
--  utc <- getCurrentTime
--  return $ formatTime defaultTimeLocale "%m/%d/%Y" utc

main = do
        print $ getFormatedDate
--        getFormatedDate >>= putStrLn
