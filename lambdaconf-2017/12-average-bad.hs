#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

tee :: Conduit Double IO Double
tee = mapMC $ \d -> print d >> pure d

main :: IO ()
main = do
  let total = runConduitPure $ yieldMany [1 .. 10 :: Double] .| sumC
  let n = runConduitPure $ yieldMany [1 .. 10 :: Double] .| lengthC
  print total
  print n
  print $ total / n
  result <-
    runConduit $
    yieldMany [1 .. 10 :: Double] .| tee .|
    ((/) <$> sumC <*> lengthC) -- lengthC here gets no elements.
  print result
