data Nat = Zero | Succ Nat

instance Eq Nat where
  Zero == Zero   = True
  Zero == Succ n = False
  Succ m == Zero = False
  Succ m == Succ n = m == n

instance Show Nat where
  show Zero            = "Zero"
  show (Succ Zero)     = "Succ Zero"
  show (Succ (Succ n)) = "Succ (" ++ show (Succ n) ++ ")"


instance Num Nat where
  m + Zero        = m
  m + Succ n      = Succ (m + n)
  m * Zero        = Zero
  m * (Succ n)    = m * n + m
  abs n           = n
  signum Zero     = Zero
  signum (Succ n) = Succ Zero
  m - Zero        = m
  Zero - Succ n   = Zero
  Succ m - Succ n = m - n
  fromInteger x
    | x <= 0    = Zero
    | otherwise = Succ (fromInteger (x - 1))

--let x = Succ 1

instance Ord Nat where
{-
  compare Zero Zero   = EQ
  compare Zero (Succ n) = LT
  compare (Succ m) Zero = GT
  compare (Succ m) (Succ n) = compare m n
-}
  Zero <= Zero = True
  Zero <= Succ n = True
  Succ m <= Zero = False
  Succ m <= Succ n = m <= n


divMod2 :: Nat -> Nat -> (Nat, Nat)
{-
divMod2 Zero _ = (Zero, Zero)
divMod2 _ Zero = undefined
divMod2 (Succ m) (Succ n) = (Succ x, Succ y)
  where
    (x, y) = divMod m n
-}
divMod2 _ Zero = undefined

divMod2 x y = if x < y then (Zero, x)
             else (Succ q, r)
  where
    (q, r) = divMod2 (x - y) y
    
{-
*Main> [Zero, fromInteger(10)]
[Zero,Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))))]
-}
