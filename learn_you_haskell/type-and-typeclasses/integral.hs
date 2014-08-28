{-
let int20 = 20::Int
let integer20 = 20::Integer
let float20 = 20::Float
let doubl20 = 20::Double
-}
int20 = 20::Int
integer20 = 20::Integer
float20 = 20::Float
double20 = 20::Double

int40 = int20 + fromIntegral integer20
double40 = double20 + fromIntegral integer20
-- integer40 = integer20 + fromIntegral float20 --NG
integer40 = integer20 + round float20
-- RealFrac has ceiling(), floor(), truncate(), round().
