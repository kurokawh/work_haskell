#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle
import Turtle

main = pwd >>= print

