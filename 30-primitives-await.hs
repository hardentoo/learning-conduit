#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

main :: IO ()
main = do
  -- prints: Just 1
  print $ runConduitPure $ yield 1 .| await
  print $ runConduitPure $ yieldMany [1..3] .| await
  print $ runConduitPure $ yieldMany [1..] .| await

  -- prints: Nothing
  print $ runConduitPure $ yieldMany [] .| await

  -- Note, that the above is equivalent to the following. Work out
  -- why this works:
  print $ runConduitPure $ return () .| await
  print $ runConduitPure await
