NatSum = Main +
consts sum :: nat => nat
primrec
"sum 0 = 0"
"sum (Suc n) = Suc n + sum n"
end
