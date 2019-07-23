//
//  MinPQ.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
class MinPQ <El> {
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
