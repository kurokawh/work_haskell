import Data.Char
import Data.Function -- for `on`
import Data.List -- groubBy

-- isControl checks whether a character is a control character.
-- isSpace checks whether a character is a white-space characters. That includes spaces, tab characters, newlines, etc.
-- isLower checks whether a character is lower-cased.
-- isUpper checks whether a character is upper-cased.
-- isAlpha checks whether a character is a letter.
-- isAlphaNum checks whether a character is a letter or a number.
-- isPrint checks whether a character is printable. Control characters, for instance, are not printable.
-- isDigit checks whether a character is a digit.
-- isOctDigit checks whether a character is an octal digit.
-- isHexDigit checks whether a character is a hex digit.
-- isLetter checks whether a character is a letter.
-- isMark checks for Unicode mark characters. Those are characters that combine with preceding letters to form latters with accents. Use this if you are French.
-- isNumber checks whether a character is numeric.
-- isPunctuation checks whether a character is punctuation.
-- isSymbol checks whether a character is a fancy mathematical or currency symbol.
-- isSeparator checks for Unicode spaces and separators.
-- isAscii checks whether a character falls into the first 128 characters of the Unicode character set.
-- isLatin1 checks whether a character falls into the first 256 characters of Unicode.
-- isAsciiUpper checks whether a character is ASCII and upper-case.
-- isAsciiLower checks whether a character is ASCII and lower-case.


-- We can use the Data.List function all in combination with 
-- the Data.Char predicates to determine if the username is alright.
ia1 = all isAlphaNum "bobby283"  
-- True  
ia2 = all isAlphaNum "eddy the fish!"  
-- False  


w1 = words "hey guys its me"  
-- ["hey","guys","its","me"]  
gb1 = groupBy ((==) `on` isSpace) "hey guys its me"  
-- ["hey"," ","guys"," ","its"," ","me"]  
f1 = filter (not . any isSpace) . groupBy ((==) `on` isSpace) $ "hey guys its me"  
-- ["hey","guys","its","me"]  



-- The GeneralCategory type is also an enumeration. 
-- It presents us with a few possible categories that a character can fall into. 
-- The main function for getting the general category of a character is 
-- generalCategory. It has a type of generalCategory :: Char -> GeneralCategory. 
gc1 = generalCategory ' '  
-- Space  
gc2 = generalCategory 'A'  
-- UppercaseLetter  
gc3 = generalCategory 'a'  
-- LowercaseLetter  
gc4 = generalCategory '.'  
-- OtherPunctuation  
gc5 = generalCategory '9'  
-- DecimalNumber  
gc6 = map generalCategory " \t\nA9?|"  
-- [Space,Control,Control,UppercaseLetter,DecimalNumber,OtherPunctuation,MathSymbol]  


-- toUpper converts a character to upper-case. Spaces, numbers, and the like remain unchanged.
-- toLower converts a character to lower-case.
-- toTitle converts a character to title-case. For most characters, title-case is the same as upper-case.
-- digitToInt converts a character to an Int. To succeed, the character must be in the ranges '0'..'9', 'a'..'f' or 'A'..'F'.
di1 = map digitToInt "34538"  
-- [3,4,5,3,8]  
di2 =  map digitToInt "FF85AB"  
-- [15,15,8,5,10,11]  
-- intToDigit is the inverse function of digitToInt. It takes an Int in the range of 0..15 and converts it to a lower-case character.
id1 = intToDigit 15  
-- 'f'  
id2 = intToDigit 5  
-- '5'  


-- ord and chr functions convert characters to their corresponding numbers and vice versa:
oc1 = ord 'a'  
-- 97  
oc2 =  chr 97  
-- 'a'  
oc3 = map ord "abcdefgh"  
-- [97,98,99,100,101,102,103,104]  


-- encode/decode
encode :: Int -> String -> String  
encode shift msg = 
    let ords = map ord msg  
        shifted = map (+ shift) ords  
    in  map chr shifted  
en1 = encode 3 "Heeeeey"  
-- "Khhhhh|"  
en2 =  encode 4 "Heeeeey"  
-- "Liiiii}"  
en3 = encode 1 "abcd"  
-- "bcde"  
en4 = encode 5 "Marry Christmas! Ho ho ho!"  
-- "Rfww~%Hmwnxyrfx&%Mt%mt%mt&"  

decode :: Int -> String -> String  
decode shift msg = encode (negate shift) msg  
de1 = encode 3 "Im a little teapot"  
-- "Lp#d#olwwoh#whdsrw"  
de2 = decode 3 "Lp#d#olwwoh#whdsrw"  
-- "Im a little teapot"  
de3 = decode 5 . encode 5 $ "This is a sentence"  
-- "This is a sentence"  
