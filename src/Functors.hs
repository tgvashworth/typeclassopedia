-- | Main entry point to the application.
module Functors where

import           Control.Applicative
import           Data.Char

-- Pair

data Pair a = Pair a a deriving (Show)

pair :: a -> Pair a
pair x = Pair x x

first :: Pair a -> a
first (Pair x _) = x

second :: Pair a -> a
second (Pair _ y) = y

instance Functor Pair where
    fmap f (Pair x y) = Pair (f x) (f y)
instance Applicative Pair where
    pure = pair
    (Pair f g) <*> (Pair x y) = Pair (f x) (g y)
-- Can't be a Monad

-- Option

data Option a = Some a | None deriving (Show)

instance Functor Option where
    fmap _ None = None
    fmap f (Some x) = Some (f x)
instance Applicative Option where
    pure              = Some
    _ <*> None        = None
    None <*> _        = None
    Some f <*> Some x = Some (f x)
instance Monad Option where
    return         = Some
    (Some x) >>= k = k x
    None >>= _     = None
   

main = print $
    Some 1 >>= return . (+1)
