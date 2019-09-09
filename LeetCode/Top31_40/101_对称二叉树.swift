//
//  101_对称二叉树.swift
//  DataStruct
//
//  Created by lijian on 2019/9/9.
//  Copyright © 2019 lijian. All rights reserved.
//

import Cocoa

class Solution_101_对称二叉树: LeetCodeTreeNode {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return isMirror(root?.left, root?.right)
    }
    
    func isMirror(_ node1:TreeNode?,_ node2:TreeNode?) -> Bool {
        //退出条件
        if node1==nil && node2==nil {//都为空，认为对称
            return true
        }
        if node1==nil || node2==nil { //只有一个为空，不对称
            return false
        }
        return (node1!.val==node2!.val)&&isMirror(node1?.right, node2?.left)&&isMirror(node1?.left, node2?.right)
    }
}


public boolean isSymmetric(TreeNode root) {
    Queue<TreeNode> q = new LinkedList<>();
    q.add(root);
    q.add(root);
    while (!q.isEmpty()) {
        TreeNode t1 = q.poll();
        TreeNode t2 = q.poll();
        if (t1 == null && t2 == null) continue;
        if (t1 == null || t2 == null) return false;
        if (t1.val != t2.val) return false;
        q.add(t1.left);
        q.add(t2.right);
        q.add(t1.right);
        q.add(t2.left);
    }
    return true;
}

