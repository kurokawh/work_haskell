-- http://postd.cc/how_do_type_classes_differ_from_interfaces/

-- import Control.Exception

class CanFail failable where
    oops :: failable a
    pick :: failable a -> failable a -> failable a
    win  :: a -> failable a

instance CanFail Maybe where
    oops = Nothing
    pick (Just a) _ = Just a
    pick Nothing (Just a) = Just a
    pick Nothing Nothing = oops
    win a = Just a

safeDivision :: CanFail failable => Double -> Double -> failable Double
safeDivision x y =
    if y == 0 
       then oops
       else win (x / y)


-- use Maybe
someMathFunction :: Double -> Double -> Double
someMathFunction x y =
    let result = safeDivision x y in
    case result of
        Just number -> 
            number * 3
        Nothing ->
            0

-- use MaybeError
data MaybeError a = Error String | Result a 
instance CanFail MaybeError where
    oops = Error "oops"
    pick (Result a) _ = Result a
    pick _ (Result a) = Result a
    pick _ _ = oops
    win a = Result a

-- Now I can also select the MaybeError type! 
-- If I want to, I can also make it an instance of IO:    
-- simplified. Runs an action and catches an exception.
try :: IO a -> IO (MaybeError a)
try = undefined
throwException x = undefined
instance CanFail IO where
    oops = throwException "oops"
    pick first second = do
        eResult <- try first
        case eResult of
            Result a ->
                return a
            Error exception ->
                second
    win a = return a

-- Now, we can use our safeDivision function in IO, 
-- just like it were print or similar!
main :: IO ()
main = do
    putStrLn "Woah, look at us!" :: IO ()
    x <- safeDivision 3 2        :: IO Double
    putStrLn "the result was: "
    print x
    y <- safeDivision 3 0
    print "This never happens because we threw an exception!"
    
