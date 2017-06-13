#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Control.Arrow
import Control.Monad
import Data.Foldable
import Data.Monoid
import Data.Traversable

-- Using foldMap.
average1 :: [Double] -> Double
average1 = uncurry (/) . join (***) getSum . foldMap (Sum &&& Sum . const 1)

-- Using mapAccumL.
average2 :: [Double] -> Double
average2 = uncurry (/) . fst . mapAccumL f (0, 0)
  where
    f :: (Double, Double) -> Double -> ((Double, Double), Double)
    f (total, len) b = ((total + b, len + 1), b)

-- Using foldl' (don't need full power of mapAccumL).
average3 :: [Double] -> Double
average3 = uncurry (/) . foldl' f (0, 0)
  where
    f :: (Double, Double) -> Double -> (Double, Double)
    f (total, len) b = (total + b, len + 1)

main :: IO ()
main = do
  let ns = [1 .. 10]
  mapM_ (\f -> print $ f ns) [average1, average2, average3]
