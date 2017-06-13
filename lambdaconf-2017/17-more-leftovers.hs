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
  runConduit $
  yieldMany [1 .. 10 :: Int]
  .| do
    mapC id .| (await >>= maybe (return ()) leftover)
    printC
  .| do
    leftover "Hello There!"
    printC
