Working through examples from [LambdaConf 2017](http://www.snoyman.com/reveal/conduit-yesod#/).

## Some type signatures

[More types](http://www.snoyman.com/reveal/conduit-yesod#/6/7):

```haskell
runConduit $ foo .| bar .| baz

newtype ConduitM (i :: *) (o :: *) (m :: * -> *) (r :: *)

foo :: ConduitM () a    m ()
bar :: ConduitM a  b    m ()
baz :: ConduitM b  Void m r

foo .| bar :: ConduitM () b    m ()
bar .| baz :: ConduitM b  Void m r

foo .| bar .| baz :: ConduitM () Void m r
runConduit $ foo .| bar .| baz :: m r
```

[Example types](http://www.snoyman.com/reveal/conduit-yesod#/7)

```haskell
mapC        :: (i -> o)           -> ConduitM i o m ()
foldlC      :: (r -> i -> r) -> r -> ConduitM i o m r
mapM_C      :: (i -> m ())        -> ConduitM i o m ()
repeatC     :: o                  -> ConduitM i o m ()
takeWhileC  :: (i -> Bool)        -> ConduitM i i m ()
decodeUtf8C :: MonadThrow m       => Conduit ByteString m Text
```
