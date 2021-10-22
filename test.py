n = 0xFFFFFFFF
b = n
for i in range(len(str(n))):
    b /= 10**i
    b %= 10  
    b = int(b)
    print(b) 
    b = n
