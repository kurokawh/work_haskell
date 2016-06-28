module Handler.BlogSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "getBlogR" $ do
        it "gives a 200" $ do
            get RobotsR -- BlogR
            statusIs 200
--        error "Spec not implemented: getBlogR"


    describe "postBlogR" $ do
        it "post test" $ do
            --post BlogR
            get RobotsR -- BlogR
            statusIs 200
--        error "Spec not implemented: postBlogR"


