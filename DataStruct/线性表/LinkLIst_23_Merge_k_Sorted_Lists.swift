//
//  LinkLIst_23_Merge_k_Sorted_Lists.swift
//  DataStruct
//
//  Created by lijian on 2019/6/26.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class LinkLIst_23_Merge_k_Sorted_Lists: LeetCode_LinkList {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var ary = [Int]()
        for var list in lists {
            while list != nil {
                ary.append(list!.val)
                list = list?.next
            }
        }
        
        ary.sort { $0 > $1 }
        print(ary)
        var head: ListNode?
        for val in ary {
            let node = ListNode(val)
            node.next = head
            head = node
        }
        return head
    }
    
    func mergeKLists1(_ lists: [ListNode?]) -> ListNode? {
        
        //internalLists内的节点不能为空，每次移动到分两种情况处理：
        //1. 下一个元素有值（删除-添加）
        //2. 下一个元素无值（删除）
        var internalLists: [ListNode] = Array()
        for item in lists { //过滤空节点
            if item != nil {
                internalLists.append(item!)
            }
        }
        
        //上浮(最小堆) ，当老大去
        func up(_ index:Int) {
            guard index < internalLists.count  else {
                print("up function, index: \(index), internalLIsts.cout:\(internalLists.count)")
                return
            }
            
            var i: Int = index
            let upNode: ListNode = internalLists[index]
            while i >= 0 {
                //找到父节点
                let parentIndex = (i - 1) >> 1
                let parentNode: ListNode = internalLists[parentIndex]
                if parentNode.val > upNode.val { //能继续上浮
                    //子节点给我下去
                    internalLists[i] = parentNode
                    
                    //变化循环条件
                    i = parentIndex
                } else { // 已经到了合适的位置了，不能上浮了
                    break;
                }
                
                //走到这里，找到了上浮的位置，将upnode 赋值给i
                internalLists[i] = upNode
            }
        }
        
        // 下层， 当小兵去
        func down(_ index:Int) {
            guard index < internalLists.count else {
                print("down function, index: \(index), internalLIsts.cout:\(internalLists.count)")
                return
            }
            
            var i: Int = index
            let downNode = internalLists[index]
            while i < internalLists.count << 1 {
                //找到子节点中的 最小值
                var indexMin = i << 1 + 1
                if indexMin >= internalLists.count  {
                    break
                }
                var nodeMin  = internalLists[indexMin]
                
                if indexMin + 1 < internalLists.count {
                    if nodeMin.val > internalLists[indexMin + 1].val {  //表示右子节点是最小的
                        nodeMin = internalLists[indexMin + 1]
                        indexMin += 1
                    }
                }
                
                //如果downNode的值大于 子节点中的值，要下层
                if downNode.val > nodeMin.val {
                    internalLists[i] = nodeMin
                    i = indexMin
                } else {
                    break;
                }
            }
            
            //最后将down下层到合适的位置
            internalLists[i] = downNode
        }
        
        //批量建堆
        func creatHeap() {
            var  i:Int  = internalLists.count >> 1
            while i>=0 {
                down(i)
                i -= 1
            }
        }
        
        //删除一个节点
        func remove() {
            //保存最后一个节点
            if internalLists.count == 1 {
                internalLists.removeAll()
            } else {
                internalLists[0] = internalLists.last!
                internalLists.removeLast()
                down(0)
            }
        }
        
        // 取走一个最小值
        func nextNode() -> ListNode? {
            let node : ListNode? = internalLists.first
            guard node != nil else {
                print("nextNode function, node is nil")
                return nil
            }
            
            if node?.next != nil  {
                internalLists[0] = node!.next!
                down(0)
            } else {
                remove()
            }
            return node
        }
        
        
        //建堆
        creatHeap()
        let head: ListNode  = ListNode(0) //虚拟头结点
        var node: ListNode? = head

        while internalLists.count > 0 {
            node?.next = nextNode()
            node = node?.next
        }
        return head.next
    }
    
    static func testMergeKLists()  {
        
        let instance1 = LinkLIst_23_Merge_k_Sorted_Lists()
        let node1:ListNode? = instance1.createNode([1,4,5])
        let node2:ListNode? = instance1.createNode([1,3,4])
        let node3:ListNode? = instance1.createNode([2,6])
        var ret = instance1.mergeKLists([node1?.next,node2?.next,node3?.next])
        while ret != nil {
            print("最终结果：  \(ret!.val)")
            ret = ret?.next
        }
        
        /* 建堆测试
        let instance1 = LinkLIst_23_Merge_k_Sorted_Lists()
        let node1:ListNode? = instance1.createNode([90,4,5,10,1,40,50,77,88,34])
        instance1.mergeKLists([ListNode(90),
                               ListNode(4),
                                ListNode(5),
                                 ListNode(10),
                                  ListNode(1),
                                   ListNode(40),
                                    ListNode(50),
                                     ListNode(77),
                                      ListNode(88),
                                      ListNode(34),
                                      ListNode(34),
                                      ListNode(34)])
         */
//        let node2:ListNode? = instanc1.createNode([1->3->4])
//        let node3:ListNode? = instanc1.createNode([1->3->4])
        
        

        
        /*  这段代码验证  Array中可以存储nil
         var ary :[Int?] = []
        ary.append(nil)
        ary.append(1)
        var aa: Int  = ary[0]!
        if  aa != nil  {
            print(aa)
        } else {
            print("aa 是空")
        }
        
        
        var bb  = ary[1]
        if  bb != nil  {
            print(bb)
        } else {
            print("bb 是空")
        }*/
        
        
        
    }
    
}

/*
 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.
 
 Example:
 
 Input:
 [
 1->4->5,
 1->3->4,
 2->6
 ]
 Output: 1->1->2->3->4->4->5->6
 */

