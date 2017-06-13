#!/usr/bin/env stack
{-
  stack --resolver lts-8.12 script
    --package conduit-combinators
    --package unordered-containers
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

myTakeWhileC :: Monad m => (i -> Bool) -> ConduitM i i m ()
myTakeWhileC f = loop
  where
    loop = do
      mx <- await
      case mx of
        Nothing -> pure ()
        Just x
          | f x -> yield x >> loop
          | otherwise -> pure () -- throws away x here (i.e. 6)

main :: IO ()
main =
  print $
  runConduitPure $
  yieldMany [1 .. 10 :: Int] .|
  ((,) <$> (myTakeWhileC (< 6) .| sinkList) <*> sinkList)
