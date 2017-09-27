module DigitalRoot where


myplus :: Integral a => a -> a -> a
myplus x y = if x >= 10 then
               myplus (div x 10) ((mod x 10) + y)
             else
               if (y + x) >= 10 then
                 digitalRoot (y + x)
               else
                 (y + x)

digitalRoot :: Integral a => a -> a
digitalRoot x = myplus x 0
