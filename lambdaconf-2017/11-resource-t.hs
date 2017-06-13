#!/usr/bin/env stack
{-
  stack script --resolver lts-8.12
    --package conduit-combinators
    --
    -Wall -fwarn-tabs -fno-warn-type-defaults
-}
import Conduit

source :: ConduitM i Int (ResourceT IO) ()
source =
  bracketP
    (putStrLn "acquire a resource")
    (\() -> putStrLn "cleaning up")
    (\() -> mapM_ yield [1 .. 100])

main :: IO ()
main = runConduitRes $ source .| takeC 2 .| (printC >> undefined)
