#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

main :: IO ()
main = runConduit $ yieldMany [1 .. 10] .| (foldMC f 0 >>= liftIO . print)
  where
    f total x = do
      putStrLn $ "Received: " ++ show x
      return $ total + x
