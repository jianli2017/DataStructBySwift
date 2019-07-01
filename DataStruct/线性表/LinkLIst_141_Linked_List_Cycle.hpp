//
//  LinkLIst_141_Linked_List_Cycle.hpp
//  DataStruct
//
//  Created by lijian on 2019/6/27.
//  Copyright © 2019 lijian. All rights reserved.
//

#ifndef LinkLIst_141_Linked_List_Cycle_hpp
#define LinkLIst_141_Linked_List_Cycle_hpp

#include <stdio.h>

#endif /* LinkLIst_141_Linked_List_Cycle_hpp */


struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class LinkLIst_141_Linked_List_Cycle {
public:
    bool hasCycle(ListNode *head) {
        if (!head || !head->next) {
            return false;
        }
        
        ListNode *fast=head,*slow=head;
        while(fast!=NULL&&fast->next!=NULL){
            slow = slow->next;
            fast = fast->next->next;
            if(fast == slow) return true;
        }
        return false;
    }
    
};
