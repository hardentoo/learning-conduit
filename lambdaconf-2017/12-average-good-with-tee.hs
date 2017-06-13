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
  print =<<
    (runConduit $
     yieldMany [1 .. 10 :: Double] .| tee .|
     getZipSink ((/) <$> ZipSink sumC <*> ZipSink lengthC))
