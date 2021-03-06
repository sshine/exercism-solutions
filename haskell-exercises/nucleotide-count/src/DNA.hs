{-# LANGUAGE TupleSections #-}
module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map
import           Data.Map (Map)
import           Data.Validation (Validation, fromEither)
import           Text.Read (readEither)

data Nucleotide = A | C | G | T
  deriving (Eq, Ord, Show, Read, Enum, Bounded)

nucleotideCounts :: String -> Validation String (Map Nucleotide Int)
nucleotideCounts = fmap frequencies . traverse toNucleotide

toNucleotide :: Char -> Validation String Nucleotide
toNucleotide c = fromEither $ readEither [c] <> Left [c]

frequencies :: [Nucleotide] -> Map Nucleotide Int
frequencies = (`Map.union` zeroMap) . Map.fromListWith (+) . (`zip` [1,1..])

zeroMap :: Map Nucleotide Int
zeroMap = Map.fromList $ map (,0) [minBound..]
