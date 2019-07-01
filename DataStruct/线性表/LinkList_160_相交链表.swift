//
//  LinkList_160_相交链表.swift
//  DataStruct
//
//  Created by lijian on 2019/6/25.
//  Copyright © 2019 lijian. All rights reserved.
//
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */

import Foundation

class LinkList_160_相交链表 {
    class  ListNode {
        var val: Int;
        var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    };
    
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        
        if headA == nil || headB == nil  {
            return nil
        }
        
        var nodeA: ListNode? = headA
        var nodeB: ListNode? = headB
        
        var countA: Int = 0
        while nodeA != nil {
            countA += 1
            nodeA = nodeA!.next
        }
        
        var countB: Int = 0
        while nodeB != nil {
            countB += 1
            nodeB = nodeB!.next
        }
        nodeA = headA
        nodeB = headB
        let diff: Int = max(countA, countB) - min(countA, countB)
        if countA > countB {
            for _ in 0..<diff {
                nodeA = nodeA?.next
            }
        } else if countA < countB {
            for _ in 0..<diff {
                nodeB = nodeB?.next
            }
        }
        
        while nodeA != nil {
            if nodeA! === nodeB! {
                return nodeA
            }
            nodeA = nodeA?.next
            nodeB = nodeB?.next
        }
        return nil
    }
    static func testGetIntersectionNode() {
        
        
        //测试用例1
        //期望：[4,1,8,4,5]
        let headA:ListNode? = ListNode(4)
        var nodeA: ListNode? = headA
        
        nodeA?.next = ListNode(1)
        nodeA = nodeA?.next
        
        nodeA?.next = ListNode(8)
        nodeA = nodeA?.next
        
        let node:ListNode? = nodeA //相交点
        nodeA?.next = ListNode(4)
        nodeA = nodeA?.next
        nodeA?.next = ListNode(5)
        
        //[5,0,1,8,4,5]
        let headB:ListNode? = ListNode(5)
        var nodeB: ListNode? = headB
        
        nodeB?.next = ListNode(0)
        nodeB = nodeB?.next
        
        nodeB?.next = ListNode(1)
        nodeB = nodeB?.next
        
        nodeB?.next = node  //相交点
        
        let nodeIntersaction: ListNode? = LinkList_160_相交链表().getIntersectionNode(headA, headB)
        if nodeIntersaction != nil {
            print(nodeIntersaction!.val)
        }
    }
}
/*
 编写一个程序，找到两个单链表相交的起始节点。
 
 如下面的两个链表：
 
 
 
 在节点 c1 开始相交。
 
   
 
 示例 1：
 
 
 
 输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
 输出：Reference of the node with value = 8
 输入解释：相交节点的值为 8 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
   
 
 示例 2：
 
 
 
 输入：intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
 输出：Reference of the node with value = 2
 输入解释：相交节点的值为 2 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [0,9,1,2,4]，链表 B 为 [3,2,4]。在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。
   
 
 示例 3：
 
 
 
 输入：intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
 输出：null
 输入解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
 解释：这两个链表不相交，因此返回 null。
   
 
 注意：
 
 如果两个链表没有交点，返回 null.
 在返回结果后，两个链表仍须保持原有的结构。
 可假定整个链表结构中没有循环。
 程序尽量满足 O(n) 时间复杂度，且仅用 O(1) 内存。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/intersection-of-two-linked-lists
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

/*
class Solution {
    public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
    if(!headA || !headB)    return nullptr;
    ListNode *nodeA = headA;
    ListNode *nodeB = headB;
    int countA = 0;
    int countB = 0;
    while(nodeA){
    ++countA;
    nodeA = nodeA->next;
    }
    while(nodeB){
    ++countB;
    nodeB = nodeB->next;
    }
    int i = max(countA,countB) - min(countA,countB);
    if(countA > countB)
    for(i; i > 0; --i)
    headA = headA->next;
    else
    for(i; i > 0; --i)
    headB = headB->next;
    
    while(headA) {
    if(headA == headB)  return headA;
    headA = headA->next;
    headB = headB->next;
    }
    return nullptr;
    }
};

 
 作者：youlookdeliciousc
 链接：https://leetcode-cn.com/problems/two-sum/solution/cxiang-xi-ti-jie-by-youlookdeliciousc-12/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
