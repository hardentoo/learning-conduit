#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

main :: IO ()
main = do
  print $
    runConduitPure $
    yieldMany [1 .. 10 :: Double] .|
    getZipSink ((/) <$> ZipSink sumC <*> ZipSink lengthC)
