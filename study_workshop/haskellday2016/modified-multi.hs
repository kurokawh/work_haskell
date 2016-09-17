#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle

echoModified arg1 = do
  date <- datefile (fromText arg1)
  echo (repr date)



main = do
  args <- arguments
  mapM echoModified args
