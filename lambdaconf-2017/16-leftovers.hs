#!/usr/bin/env stack
{-
  stack --resolver lts-8.12 script
    --package conduit-combinators
    --package unordered-containers
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

main :: IO ()
main =
  print $
  runConduitPure $
  yieldMany [1 .. 10 :: Int] .|
  ((,) <$> (takeWhileC (< 6) .| sinkList) <*> sinkList)
