#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Data.Text

nestedIO = do
    putStr "Hello, "
    return (putStrLn "I/O!")


main = do
  io <- nestedIO
  io

