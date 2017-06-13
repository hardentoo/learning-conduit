#!/usr/bin/env stack
-- stack --resolver lts-8.12 script --package conduit-combinators
import Conduit

main = runConduit $ return () .| undefined .| return ()
