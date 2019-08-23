//
//  94_二叉树的中序遍历.swift
//  DataStruct
//
//  Created by lijian on 2019/8/14.
//  Copyright © 2019 lijian. All rights reserved.
//


/*
 给定一个二叉树，返回它的中序 遍历。
 
 示例:
 
 输入: [1,null,2,3]
 1
 \
 2
 /
 3
 
 输出: [1,3,2]
 进阶: 递归算法很简单，你可以通过迭代算法完成吗？
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/binary-tree-inorder-traversal
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

import Foundation

class Solution_94_二叉树的中序遍历: LeetCodeTreeNode {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        var stack = Stack<TreeNode>()
         
        var node = root
        while node != nil || !stack.isEmpty()  {
            while node != nil {
                stack.push(node!)
                node = node?.left;
            }
            
            if !stack.isEmpty() {
                node = stack.pop()
                res.append(node!.val)
                node = node?.right
            }
        }
        return res
    }
}
