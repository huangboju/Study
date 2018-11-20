//
//  FindMedian.swift
//  Algorithm
//
//  Created by 黄伯驹 on 2018/6/12.
//  Copyright © 2018 伯驹 黄. All rights reserved.
//

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let m = nums1.count
    let n = nums2.count
    
    if m > n {
        return findMedianSortedArrays(nums2, nums1)
    }
    
    let halfLength = (m + n + 1) >> 1
    var b = 0, e = m
    var maxOfLeft = 0
    var minOfRight = 0
    
    while b <= e {
        let mid1 = (b + e) >> 1
        let mid2 = halfLength - mid1
        
        if mid1 > 0 && mid2 < n && nums1[mid1 - 1] > nums2[mid2] {
            e = mid1 - 1
        } else if mid2 > 0 && mid1 < m && nums1[mid1] < nums2[mid2 - 1] {
            b = mid1 + 1
        } else {
            if mid1 == 0 {
                maxOfLeft = nums2[mid2 - 1]
            } else if mid2 == 0 {
                maxOfLeft = nums1[mid1 - 1]
            } else {
                maxOfLeft = max(nums1[mid1 - 1], nums2[mid2 - 1])
            }
            
            if (m + n) % 2 == 1 {
                return Double(maxOfLeft)
            }
            
            if mid1 == m {
                minOfRight = nums2[mid2]
            } else if mid2 == n {
                minOfRight = nums1[mid1]
            } else {
                minOfRight = min(nums1[mid1], nums2[mid2])
            }
            
            break
        }
    }
    return Double(maxOfLeft + minOfRight) / 2.0
}

class Method {
    func findMedian(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let n = nums1.count + nums2.count
        
        if n % 2 == 0 {
            return Double(findKth(nums1, nums2, n / 2) + findKth(nums1, nums2, n / 2 + 1)) / 2.0
        }
        
        return Double(findKth(nums1, nums2, n / 2 + 1))
    }
    
    func findKth(_ A: [Int], _ B: [Int], _ k: Int) -> Int {
        if A.isEmpty {
            return B[k - 1]
        }
        if B.isEmpty {
            return A[k - 1]
        }
        
        var start = min(A[0], B[0])
        var end = max(A[A.endIndex - 1], B[B.endIndex - 1])
        
        // find first x that >= k numbers is smaller or equal to x
        while start + 1 < end {
            let mid = start + (end - start) / 2
            if countSmallerOrEqual(A, mid) + countSmallerOrEqual(B, mid) < k {
                start = mid
            } else {
                end = mid
            }
        }
        
        if (countSmallerOrEqual(A, start) + countSmallerOrEqual(B, start) >= k) {
            return start
        }
        
        return end
    }
    
    func countSmallerOrEqual(_ arr: [Int], _ number: Int) -> Int {
        var start = 0, end = arr.endIndex - 1
        
        // find first index that arr[index] > number
        while start + 1 < end {
            let mid = start + (end - start) / 2
            if arr[mid] <= number {
                start = mid
            } else {
                end = mid
            }
        }
        
        if arr[start] > number {
            return start
        }
        
        if arr[end] > number {
            return end
        }
        
        return arr.count
    }
}




public func findMedianSorted(_ A: [Int], _ B: [Int]) -> Double {
    let n = A.count + B.count
    
    func findKth(_ A: [Int], _ startOfA: Int, _ B: [Int], _ startOfB: Int, _ k: Int) -> Int {
        if startOfA >= A.count {
            return B[startOfB + k - 1]
        }
        if startOfB >= B.count {
            return A[startOfA + k - 1]
        }
        
        if k == 1 {
            return min(A[startOfA], B[startOfB])
        }
        
        let n = startOfA + k / 2 - 1
        let halfKthOfA = n < A.count ? A[n] : Int.max
        
        let m = startOfB + k / 2 - 1
        let halfKthOfB = m < B.count ? B[m] : Int.max
        
        if halfKthOfA < halfKthOfB {
            return findKth(A, startOfA + k / 2, B, startOfB, k - k / 2)
        } else {
            return findKth(A, startOfA, B, startOfB + k / 2, k - k / 2)
        }
    }

    if n % 2 == 0 {
        return Double(findKth(A, 0, B, 0, n / 2) + findKth(A, 0, B, 0, n / 2 + 1)) / 2.0
    }
    
    return Double(findKth(A, 0, B, 0, n / 2 + 1))
}
