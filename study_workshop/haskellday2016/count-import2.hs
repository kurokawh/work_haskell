#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Data.Text (unpack, pack)

callgrep shellfile = do
--  view shellfile
  f <- shellfile
  input (fromString f) & grep (prefix "import")

callfind src = find (suffix ".hs") src

--countimport src = empty & callfind src & callgrep & shell "wc -l"
countimport src = shell "wc -l" (
  callgrep (
    callfind (
      fromText src)))

main = do
  args <- arguments
  let src = head args
  countimport src
  return ()
  
