#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle

main = do
  args <- arguments
  let arg1 = head args
  date <- datefile (fromText arg1)
  echo (repr date)
