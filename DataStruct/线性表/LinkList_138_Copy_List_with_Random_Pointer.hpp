//
//  LinkList_138_Copy_List_with_Random_Pointer.hpp
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

#ifndef LinkList_138_Copy_List_with_Random_Pointer_hpp
#define LinkList_138_Copy_List_with_Random_Pointer_hpp

#include <stdio.h>

#endif /* LinkList_138_Copy_List_with_Random_Pointer_hpp */
#include <unordered_map>
class Node {
public:
    int val;
    Node* next;
    Node* random;
    
    Node() {}
    
    Node(int _val, Node* _next, Node* _random) {
        val = _val;
        next = _next;
        random = _random;
    }
};

using namespace std;
class LinkList_138_Copy_List_with_Random_Pointer {
public:
    Node* copyRandomList(Node* head) {
        //哨兵节点，方便操作
        Node *new_head = new Node(0,NULL,NULL);
        Node *copy_temp = new_head;
        
        unordered_map<Node *, Node *> nodemap;
        
        
        // 建立新链表
        Node *temp = head; //第一次的循环循环变量
        while (temp)
        {
            copy_temp->next = new Node(temp->val,NULL,NULL);
            nodemap[temp] = copy_temp->next;
            
            temp = temp->next;
            copy_temp = copy_temp->next;
        }
        
        Node *random_temp = NULL;
        temp = head;
        copy_temp = new_head->next;
        // 填充新链表的随机指针
        while (temp)
        {
            random_temp = temp->random;
            if (random_temp != NULL)   copy_temp->random = nodemap[random_temp];
            else
                copy_temp->random = NULL;
            
            temp = temp->next;
            copy_temp = copy_temp->next;
        }
        
        return new_head->next;
    }
    
};
