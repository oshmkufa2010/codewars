rot13 = map trans
        where
          trans x
            |isAlpha x =
              let base = if (isUpper x) then (ord 'A') else (ord 'a' )
                in chr ((mod ((ord x) + 13 - base) 26) + base)
            |otherwise = x
let putsn n = foldl1 (\m a -> (m >>= (\x -> m))) (replicate n (putStrLn "Hello World"))

solve l r as bs = sum $ map (\i -> (* 0.0005) $ (f i / 1000) + (f (i + 1) / 1000)) [l*1000..(r-1)*1000] where f x = sum $ map (\(a, b) -> a * x ^ b) $ zip as bs 
