'''
Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9, return [0, 1].'''
'''
def twoSum(self, nums: List[int], target: int) -> List[int]:
        hash_table = {}
        for i, n in enumerate(nums):
            if target - n in hash_table:
                return [hash_table[target - n], i]
            else:
                hash_table[n] = i
'''




def twoSum(nums, target):
    """
    :type nums: List[int]
    :type target: int
    :rtype: List[int]
    """
    d = {}
    for i, num in enumerate(nums):
      if target - num in d:
        return [d[target - num], i]
      d[num] = i

nums=[2,7,11,15]
target=9
print(twoSum(nums,target))

