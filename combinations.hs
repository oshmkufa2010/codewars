module Combinations where

combinations :: Int -> [a] -> [[a]]
combinations n l
            | n <= 0 = [[]]
            | n > len = [[]]
            | n == len = [l]
            | n < len = [(head l):y | y <- combinations (n-1) (tail l)] ++ combinations n (tail l)
            where len = length l
