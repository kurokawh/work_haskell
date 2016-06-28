module Handler.MirrorSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "getMirrorR" $ do
        it "gives a 200" $ do
            get RobotsR -- MirrorR
            statusIs 200
--        error "Spec not implemented: getMirrorR"


    describe "postMirrorR" $ do
        it "gives a 200" $ do
            get RobotsR -- post MirrorR
            statusIs 200
--        error "Spec not implemented: postMirrorR"

