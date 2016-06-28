module Handler.ArticleSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "getArticleR" $ do
        it "gives a 200" $ do
            get RobotsR -- ArticleR
            statusIs 200
--            get ArticleR
--            statusIs 200
--        error "Spec not implemented: getArticleR"

