#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

foldIt :: ConduitM Integer o IO Integer
foldIt = foldMC f 0
  where
    f total x = do
      putStrLn $ "Received: " ++ show x
      return $ total + x

main :: IO ()
main = print =<< runConduit (yieldMany [1 .. 10] .| foldIt)
