{- ------------- Expr.hsというファイル --------------- -}
module Expr where

--import qualified Language.Haskell.TH as TH
import Language.Haskell.TH
import Language.Haskell.TH.Quote

data Expr  =  IntExpr Integer
           |  AntiIntExpr String
           |  BinopExpr BinOp Expr Expr
           |  AntiExpr String
    deriving(Show, Typeable, Data)

data BinOp  =  AddOp
            |  SubOp
            |  MulOp
            |  DivOp
    deriving(Show, Typeable, Data)

eval :: Expr -> Integer
eval (IntExpr n)        = n
eval (BinopExpr op x y) = (opToFun op) (eval x) (eval y)
  where
    opToFun AddOp = (+)
    opToFun SubOp = (-)
    opToFun MulOp = (*)
    opToFun DivOp = div

expr = QuasiQuoter { quoteExp = parseExprExp, quotePat =  parseExprPat }

-- Exprをパースし、その表現をQ ExpまたはQ Patとして返す。
-- SYBを使うことによって、二つのパーサを別々に書くことなく
-- 一つのString -> Exprという型のパーサを書くだけで済ます
-- 方法については、参照先の論文を見よ。

parseExprExp :: String -> Q Exp
parseExprExp = undefined

parseExprPat :: String -> Q Pat
parseExprPat = undefined
