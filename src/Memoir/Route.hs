{-# LANGUAGE TypeApplications #-}

module Memoir.Route where

import Data.Time (Day, fromGregorianValid, toGregorian)
import Ema.Route (IsRoute (..), Slug (unSlug))

data Route
  = Index
  | OnDay Day
  deriving (Show)

instance IsRoute Route where
  toSlug = \case
    Index -> mempty
    OnDay day ->
      let (y, m, d) = toGregorian day
       in [show y, show m, show d]
  fromSlug = \case
    [] -> Just Index
    [y, m, d] ->
      OnDay <$> do
        y' <- readMaybe @Integer (toString $ unSlug y)
        m' <- readMaybe @Int (toString $ unSlug m)
        d' <- readMaybe @Int (toString $ unSlug d)
        fromGregorianValid y' m' d'
    _ -> Nothing