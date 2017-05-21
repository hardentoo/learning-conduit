#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

source :: Monad m => ConduitM i Int m ()
source = do
  yieldMany [1..10]
  yieldMany [11..20]

main :: IO ()
main = runConduit $ source .| mapM_C print
