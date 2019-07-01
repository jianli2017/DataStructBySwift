//
//  LinkList_109_Convert_Sorted_List_to_Binary_Search_Tree.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_109_Convert_Sorted_List_to_Binary_Search_Tree: LeetCode_LinkList {
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        guard head != nil else {
            return nil
        }
        
        guard head?.next != nil else {
            return TreeNode(head!.val)
        }
        
        var slow = head
        var fast = head
        var last = slow
        
        while fast != nil && fast?.next != nil  {
            last = slow  //记录中间点，断指针使用
            slow = slow?.next
            fast = fast?.next?.next
        }
        fast = slow?.next
        last?.next = nil
        let cur = TreeNode(slow!.val)
        if head !== slow {
            cur.left = sortedListToBST(head)
        }
        cur.right = sortedListToBST(fast)
        
        return cur
    }
}
/*
18 class Solution {
    19 public:
    20     TreeNode *sortedListToBST(ListNode *head) {
    21         if (!head) return NULL;
    22         if (!head->next) return new TreeNode(head->val);
    23         ListNode *slow = head;
    24         ListNode *fast = head;
    25         ListNode *last = slow;
    26         while (fast->next && fast->next->next) {
    27             last = slow;
    28             slow = slow->next;
    29             fast = fast->next->next;
    30         }
    31         fast = slow->next;
    32         last->next = NULL;
    33         TreeNode *cur = new TreeNode(slow->val);
    34         if (head != slow) cur->left = sortedListToBST(head);
    35         cur->right = sortedListToBST(fast);
    36         return cur;
    37     }
    38 };
*/

/*
给定一个单链表，其中的元素按升序排序，将其转换为高度平衡的二叉搜索树。

本题中，一个高度平衡二叉树是指一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1。

示例:

给定的有序链表： [-10, -3, 0, 5, 9],

一个可能的答案是：[0, -3, 9, -10, null, 5], 它可以表示下面这个高度平衡二叉搜索树：

0
/ \
-3   9
/   /
-10  5

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/convert-sorted-list-to-binary-search-tree
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
