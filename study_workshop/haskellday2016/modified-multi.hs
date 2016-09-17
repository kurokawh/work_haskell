#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Data.Text

echoModified file = do
  date <- datefile (fromText file)
  putStr ((unpack file) ++ "\t")
  echo (repr date)



main = do
  args <- arguments
  mapM echoModified args
