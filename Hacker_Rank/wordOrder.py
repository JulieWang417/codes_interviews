"""
link: https://www.hackerrank.com/challenges/word-order/problem?h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen
Input:
4
bcdef
abcdefg
bcde
bcdef
Output:
3
2 1 1
"""
l={}
for i in range(int(input("Enter words :"))):
    x=input()
    if x not in l:
        l[x]=1
    else:
        l[x]=l[x]+1
print(len(l))
print(l)
for i in l:
    print(l[i], end=" ") 