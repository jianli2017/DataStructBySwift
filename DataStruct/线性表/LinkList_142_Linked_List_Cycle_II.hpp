//
//  LinkList_142_Linked_List_Cycle_II.hpp
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

#ifndef LinkList_142_Linked_List_Cycle_II_hpp
#define LinkList_142_Linked_List_Cycle_II_hpp

#include <stdio.h>

#endif /* LinkList_142_Linked_List_Cycle_II_hpp */
struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
public:
    ListNode *detectCycle(ListNode *head) {
        ListNode *slow = head, *fast = head;
        while (fast && fast -> next) {        //判断是否有环
            slow = slow -> next;
            fast = fast -> next -> next;
            if (slow == fast) {                //找环的起点
                ListNode *ret = head;
                while (ret != slow) {
                    ret = ret -> next;
                    slow = slow -> next;
                }
                return ret;
            }
        }
        return NULL;
    }
};

/*
 给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
 
 为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。
 
 说明：不允许修改给定的链表。
 
  
 
 示例 1：
 
 输入：head = [3,2,0,-4], pos = 1
 输出：tail connects to node index 1
 解释：链表中有一个环，其尾部连接到第二个节点。
 
 
 示例 2：
 
 输入：head = [1,2], pos = 0
 输出：tail connects to node index 0
 解释：链表中有一个环，其尾部连接到第一个节点。
 
 
 示例 3：
 
 输入：head = [1], pos = -1
 输出：no cycle
 解释：链表中没有环。
 
 
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/linked-list-cycle-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
