//
//  LinkList_237_删除链表中的节点.swift
//  DataStruct
//
//  Created by lijian on 2019/6/21.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkList_237_删除链表中的节点: LeetCode_LinkList {
    func remove(_ node: ListNode)->Void {
        if node.next != nil {
            node.val = node.next!.val
            node.next = node.next?.next
        }
    }
}

/* C++
class Solution {
    public:
    void deleteNode(ListNode* node) {
    if (node->next != NULL) {
    node->val = node->next->val;
    node->next = node->next->next;
    }
    }
};
*/

/*
extension LinkList {
    func remove(_ node: Node)->Void {
        if node.next != nil {
            node.element = node.next!.element
            node.next = node.next?.next
            count = count - 1
        }
    }
    
    static func test1() {
        let linkList = LinkList<Int>()
        
        //测试添加
        //期望：
        linkList.add(index: 0, element: 4)
        linkList.add(index: 1, element: 5)
        linkList.add(index: 2, element: 1)
        linkList.add(index: 3, element: 9)
        linkList.printLink()
        linkList.remove(linkList.first!.next!)
        linkList.printLink()

    }
        
}*/

/*
 请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点，你将只被给定要求被删除的节点。
 
 现有一个链表 -- head = [4,5,1,9]，它可以表示为:
 
 
 
   
 
 示例 1:
 
 输入: head = [4,5,1,9], node = 5
 输出: [4,1,9]
 解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
 示例 2:
 
 输入: head = [4,5,1,9], node = 1
 输出: [4,5,9]
 解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
   
 
 说明:
 
 链表至少包含两个节点。
 链表中所有节点的值都是唯一的。
 给定的节点为非末尾节点并且一定是链表中的一个有效节点。
 不要从你的函数中返回任何结果。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/delete-node-in-a-linked-list
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
