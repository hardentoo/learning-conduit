Examples from [LambdaConf 2017](http://www.snoyman.com/reveal/conduit-yesod#/)

## Some type signatures

```haskell
mapC        :: (i -> o)           -> ConduitM i o m ()
foldlC      :: (r -> i -> r) -> r -> ConduitM i o m r
mapM_C      :: (i -> m ())        -> ConduitM i o m ()
repeatC     :: o                  -> ConduitM i o m ()
takeWhileC  :: (i -> Bool)        -> ConduitM i i m ()
decodeUtf8C :: MonadThrow m       => Conduit ByteString m Text
```
