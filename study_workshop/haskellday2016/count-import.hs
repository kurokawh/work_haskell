#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Data.Text (unpack)

callgrep shellfile = do
--  view shellfile
  f <- shellfile
  input (fromString $ unpack f) & grep (prefix "import")

countimport callfind = empty & inshell callfind & callgrep & shell "wc -l"

main = do
  args <- arguments
  let src = head args
  let callfind = format ("find "%s%" -name \\*.hs") src
  countimport callfind
  
