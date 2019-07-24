//
//  MinPQ.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


struct MinPQ <Element> {
    ///存放元素的数组
    var elements: [Element]
    //比较两个元素大小的方法
    let priorityFunction: (Element, Element) -> Bool
    
    init(elements: [Element] = [], priorityFunction: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        buildHeap()
    }
    
    mutating func buildHeap() {  //这就是自下而上的下沉，类似于删除元素，所有能保证堆的性质
        for index in (0 ..< count / 2).reversed() {
            siftDown(index)
        }
    }
    
    var isEmpty : Bool {
        return elements.isEmpty
    }
    
    var count : Int {
        return elements.count
    }
    
    func peek() -> Element? {//偷偷看看优先级最高的元素是啥
        return elements.first
    }
    func isRoot(_ index: Int) -> Bool {
        return (index == 0)
    }
    ///当前节点的左孩子
    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    ///当前节点的右孩子
    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    ///当前节点的父节点
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    //插入
    mutating func equeue(_ element: Element) {
        elements.append(element)  //插入最后，然后不断的上浮到合适的位置
        siftUP(elementAtIndex: elements.count - 1)
    }
    
    //删除
    mutating func dequeue() -> Element? {
        //判空
        guard !isEmpty else {
            return nil
        }
        
        //将第一个节点和最后一个节点交换位置
        swapElement(at: 0, with: count - 1)
        //删除原本的第一个，现在的最后一个
        let ret = elements.removeLast()

        //向下判断，新的节点是不是优先级最高的节点
        siftDown(0)
        return ret
    }
}

private extension MinPQ {
    
    //比较，如果firstIndex高于secondIndex的优先级，返回true
    func isHigherPriority(firstIndex: Int, secondIndex: Int) -> Bool{
        return priorityFunction(elements[firstIndex], elements[secondIndex])
    }
    //比较两个节点那个优先级高，返回优先级高的索引
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        //判断条件： 孩子节点的索引没有超出节点个数&&孩子的优先级高于父节点，都返回父节点，否则返回孩子节点
        guard childIndex < count && isHigherPriority(firstIndex: childIndex, secondIndex: parentIndex)
            else { return parentIndex }
        return childIndex
    }
    
    //父节点 ，两个孩子节点中的优先级最高的节点索引
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex
            else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
    
    mutating func siftDown(_ elementIndex: Int) {
        //从当前节点及子节点中找出优先级最高的节点
        let highestIndex = highestPriorityIndex(for: elementIndex)
        //如果当前节点就是优先级最高的节点，直接放回
        if highestIndex == elementIndex { return }
        //如果不是优先级最高的节点，和优先级最高的节点对换位置
        swapElement(at: elementIndex, with: highestIndex)
        //从新的节点开始递归的向下判断优先级
        siftDown(highestIndex)
    }
    
    mutating func siftUP(elementAtIndex: Int)  {
        //获得父节点的索引
        let parentIndex = self.parentIndex(of: elementAtIndex)
        //如果当前节点不是根节点，比较当前节点和父节点的优先级
        guard !isRoot(elementAtIndex), isHigherPriority(firstIndex: elementAtIndex, secondIndex: parentIndex) else {
            return
        }
        //如果当前节点的优先级高于父节点，兑换位置
        swapElement(at: elementAtIndex, with: parentIndex)
        
        //递归的从新的父节点开始向上比较
        siftUP(elementAtIndex: parentIndex)
    }
}
extension MinPQ {
    func iterater() -> [Element] {
        return self.elements
    }
}
/*
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
*/
