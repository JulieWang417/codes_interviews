"""
https://leetcode.com/problems/buddy-strings/
Given two strings A and B of lowercase letters, return true if and only if we can swap two letters in A so that the result equals B.
Input: A = "ab", B = "ba"
Output: true
Input: A = "ab", B = "ab"
Output: false
Input: A = "aa", B = "aa"
Output: true
Input: A = "aaaaaaabc", B = "aaaaaaacb"
Output: true
"""
def buddyStrings(A, B):
        if len(A) != len(B): 
            return False
        if A == B:
            s = set()
            for a in A:
                if a in s:
                    return True
                s.add(a)
            return False
        else:
            pairs = []
            for a, b in zip(A, B):
                if a != b:
                    pairs.append((a, b))
                if len(pairs) >= 3:
                    return False
            return len(pairs) == 2 and pairs[0] == pairs[1][::-1]

if __name__ == '__main__':

    A = "aabcab"
    B = "abcaab"
    D = "acba"
    E = "abca"

    print("can we swap two letters in A so that the result equals B")
    print("A: ",A, "B: ",B, "--> Result: ", buddyStrings(A, B))
    print("D:", D, "E:", E, "--> Result: ", buddyStrings(D, E))
