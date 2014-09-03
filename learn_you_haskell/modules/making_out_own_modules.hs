import qualified Geometry.Sphere as Sphere  
import qualified Geometry.Cuboid as Cuboid  
import qualified Geometry.Cube as Cube  

-- compile with
-- ghc Cube.hs Cuboid.hs Geometry.hs Sphere.hs making_out_own_modules.hs

main = do  
  let a1 = Sphere.area 1
  putStr $ show a1

