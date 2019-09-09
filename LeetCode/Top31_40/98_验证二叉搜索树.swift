//
//  98_验证二叉搜索树.swift
//  DataStruct
//
//  Created by lijian on 2019/8/26.
//  Copyright © 2019 lijian. All rights reserved.
//
/*

给定一个二叉树，判断其是否是一个有效的二叉搜索树。

假设一个二叉搜索树具有如下特征：

节点的左子树只包含小于当前节点的数。
节点的右子树只包含大于当前节点的数。
所有左子树和右子树自身必须也是二叉搜索树。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/validate-binary-search-tree
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
import Foundation

class Solution_98_验证二叉搜索树: LeetCodeTreeNode {
    func isValidBST(_ root: TreeNode?) -> Bool {
        let stack: Stack<TreeNode> = Stack<TreeNode>()
        var inorder = Int.min
        var __root = root
        while !stack.isEmpty() || __root != nil {
            while __root != nil {
                stack.push(__root!)
                __root = __root!.left
            }
            
            __root = stack.pop()
            if __root!.val <= inorder {
                return false
            }
            inorder = __root!.val
            __root = __root!.right
        }
        return true
    }
}
