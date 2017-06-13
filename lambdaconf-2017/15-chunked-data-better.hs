#!/usr/bin/env stack
{-
  stack --resolver lts-8.12 exec
    --package conduit-combinators
    --package unordered-containers
    --
    ghc --make -O2 -Wall -Wall -fwarn-tabs -fno-warn-type-defaults
-}
{-# LANGUAGE TypeFamilies #-}

import Conduit
import Data.HashMap.Strict as HM
import Data.List
import Data.MonoTraversable
import Data.Ord
import GHC.Word (Word8)

word8ToChar :: Word8 -> Char
word8ToChar = toEnum . fromEnum

sinkHistogram ::
     (Monad m, Element i ~ Word8, MonoFoldable i)
  => ConduitM i o m (HashMap Char Integer)
sinkHistogram = foldlCE go HM.empty
  where
    go map1 word = HM.insertWith (+) (word8ToChar word) 1 map1

main :: IO ()
main = do
  histogram <- runConduitRes $ sourceFile "big.txt" .| sinkHistogram
  let sorted = sortOn (Down . snd) (toList histogram)
  mapM_ print $ take 10 $ sorted
