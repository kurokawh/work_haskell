{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, FlexibleInstances #-}

module TestRec where

import DataSource (defineTable)

$(defineTable "hrr.db" "test_rec")
