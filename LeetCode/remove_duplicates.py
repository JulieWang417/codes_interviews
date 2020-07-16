"""
Remove duplicates and return length of the new string
"""
def removeDup(nums):
    h = []
    for i in nums:
        if i not in h:
            h.append(i)
    return len(h)

nums = [0,0,1,1,1,2,2,3,3,4]
    
print(removeDup(nums))