#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

trans :: Monad m => ConduitM Int Int m ()
trans = do
  takeC 5 .| mapC (+ 1)
  mapC (* 2)

main :: IO ()
main = runConduit $ yieldMany [1..10] .| trans .| mapM_C print
