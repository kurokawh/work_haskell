import Data.List ( group )
import Control.Arrow

-- "AABBCCC"を"A2B2C3"にする関数
rle = concatMap (uncurry (:) . (head &&& show . length)) . group
