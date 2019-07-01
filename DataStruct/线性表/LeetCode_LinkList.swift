//
//  LeetCode_LinkList.swift
//  DataStruct
//
//  Created by lijian on 2019/6/25.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LeetCode_LinkList {
    class  ListNode {
        var val: Int;
        var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    };
    
    func createNode(_ ary: [Int]) -> ListNode? {
        let head:ListNode? = ListNode(0)
        var node: ListNode? = head
        for element in ary {
            node?.next = ListNode(element)
            node = node?.next
        }
        return head
    }
}
