//
//  LinkLIst_82_Remove_Duplicates_from_Sorted_List.swift
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
/*
 
 递归表达式 ： head.next = findnext(next)  如果第一个结点和第二个结点不一样，则第一个结点可以直接作为新链表的头结点，后面继续删除重复的过程
                         findnext(next)  如果第一个结点和第二个结点相同，则需要继续遍历，直到找到第一个与第一个结点不同的结点作为新链表的头结点
 */

class LinkLIst_82_Remove_Duplicates_from_Sorted_List: LeetCode_LinkList {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        return findNext(head)
    }
    
    func findNext(_ head: ListNode?) -> ListNode? {
        guard head != nil else {
            return head
        }
        
        guard head?.next != nil else {
            return head
        }
        var next: ListNode? = head?.next
        if  head?.val == next?.val {
            while next != nil {  //循环找到下一个不一样的
                if head?.val != next?.val {
                    break
                }
                next = next?.next
            }
            return findNext(next)
        } else {
            head?.next=findNext(next);
            return head;
        }
    }
    static func testDeleteDuplicates() {
        let  instance = LinkLIst_82_Remove_Duplicates_from_Sorted_List()
        
        
        let node = instance.createNode([1,2,3,3,4,4,5])
//        let node = instance.createNode([1,1,1,2,3])
        var ret = instance.deleteDuplicates(node?.next)
        
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
    }
}


/*  这个理解不了
 class Solution {
 public:
 ListNode* deleteDuplicates(ListNode* head) {
 if(head==NULL || head->next==NULL)
 return head;
 
 ListNode *pDel=new ListNode(0);
 pDel->next=head;
 
 ListNode *prev=pDel;
 ListNode *curr=prev->next;
 
 while(curr->next){
 if(curr->next->val!=curr->val){
 if(prev->next==curr)
 prev=curr;
 else
 prev->next=curr->next;
 }
 curr=curr->next;
 }
 
 if(prev->next!=curr)
 prev->next=curr->next;
 
 return pDel->next;
 }
 };
 */
/*
 Given a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list.
 
 Example 1:
 
 Input: 1->2->3->3->4->4->5
 Output: 1->2->5
 Example 2:
 
 Input: 1->1->1->2->3
 Output: 2->3
 */
