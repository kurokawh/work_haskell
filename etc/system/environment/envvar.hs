#!/usr/bin/env runghc

import System.Environment

main = do
        buff <- getEnv "LANG"
        putStrLn buff
