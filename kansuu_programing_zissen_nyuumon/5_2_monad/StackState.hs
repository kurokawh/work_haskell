import Control.Monad.State

push :: a -> State [a] ()
push = modify . (:)

pop :: State [a] a
pop = do
  value <- gets head
  modify tail
  return value

applyTop :: (a -> a) -> State [a] ()
applyTop f = do
  a <- pop
  push (f a)

{-

*Main> runState (applyTop (+10)) [0..9]
((),[10,1,2,3,4,5,6,7,8,9])

-}
