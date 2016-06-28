module Handler.EchoSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "getEchoR" $ do
        it "gives a 200" $ do
            get (EchoR "foo")
            statusIs 200
            htmlAllContain "body" "foo"
--        error "Spec not implemented: getEchoR"

