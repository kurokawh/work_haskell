{-# LANGUAGE TemplateHaskell, MultiParamTypeClasses, FlexibleInstances #-}

module DbRecord where

import DataSource (defineTable)

$(defineTable "hrr.db" "db_record")
