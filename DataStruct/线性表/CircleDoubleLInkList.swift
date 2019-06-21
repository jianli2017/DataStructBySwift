//
//  CircleDoubleLInkList.swift
//  DataStruct
//
//  Created by lijian on 2019/6/21.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


/*
 循环双向链表
 
 任何操作，关注4个指针：first、 last、 pre、 next,同时关注循环指针
 */

class CircleDoubleLInkList<E: Equatable> {
    //节点类，类值引用类型，
    class Node {
        //前驱节点，可以为空，定义为可选Node
        var pre: Node?
        var element: E
        //后继节点可以为空，定义为可选
        var next: Node?
        
        init(pre: Node?, element: E, next: Node?) {
            self.pre = pre
            self.element = element
            self.next = next
        }
        deinit {
            print("元素\(element) 析构" )
        }
        
    }
    
    //元素个数，不能和size方法同名，从新命名为count
    var count: Int = 0
    var first: Node?
    //定义last的目的，如果索引位于链表的后半部分，直接从last开始查找，效率提高一倍
    var last: Node?
    
    //元素的数量
    func size() -> Int {
        return count
    }
    
    //是否为空
    func isEmpty()-> Bool {
        return count == 0
    }
    
    //是否包含某个元素
    func contains(_ element: E) -> Bool {
        var node: Node? = first
        while node != nil { //这属于if和强制解包
            if node!.element == element {
                return true
            }
            node = node!.next
            
            if node === first {
                break
            }
        }
        return false
    }
    
    //返回index位置对于的元素
    func get(index: Int)->E? {
        let node: Node? = nodeOf(index: index)
        return node?.element
    }
    
    
    //设置index位置的元素
    func set(index: Int, element: E)->E? {
        let preElement:E?
        let node:Node? = nodeOf(index: index)
        preElement = node?.element
        node?.element = element
        return preElement
    }
    
    
    //往index位置添加元素
    func add(index: Int, element: E) {
        //检测index
        precondition(checkAddIndex(index), "index 错误")
        
        //分这两种请看的原因： 最后一个不能通过index找到元素
        if count == index { //往最后添加
            let oldLast = last;
            let node: Node = Node(pre: oldLast, element: element, next: first)
            if oldLast == nil { //添加第一个元素 或者count == 0
                first = node;
                last = node
                first?.pre = first
                first?.next = first
            } else {
                oldLast?.next = node
                last = node
                first?.pre = last
            }
        } else { //添加位置位 0~ count-1
            let cur: Node! = nodeOf(index: index)
            //创建节点
            let node: Node = Node(pre: cur?.pre, element: element, next: cur)
            node.pre?.next = node;
            node.next?.pre = node;
            
            if node.next === first {
                first = node;
            }
        }
        count += 1
    }
    
    
    //删除index位置对应的元素
    func remove(index: Int)->E? {
        let removedElement: E?
        let node:Node? = nodeOf(index: index)
        //保存删除的元素
        removedElement = node?.element;
        
        if count == 1 {
            first = nil
            last = nil
        } else {
            let pre = node?.pre
            let next = node?.next
            pre?.next = next
            next?.pre = pre
            if node === first {
                first = next
            }
            
            if node === last {
                last = pre
            }
        }
        count -= 1
        return removedElement
    }
    
    //查看元素的位置
    func indexOf(element: E)->Int? {
        var index: Int = 0
        var node: Node? = first
        while node != nil {
            if node!.element == element {
                return index
            }
            node = node!.next
            index += 1
            
            if node === first {
                break
            }
        }
        return nil
    }
    
    
    //清楚所有元素
    func clear() {
        var node = first
        while node != nil { // 断pre、next指针
            let newNode = node?.next
            node?.pre = nil
            node?.next = nil
            node = newNode
        }
        first = nil
        last = nil
        count = 0
    }
    
    
    //通过index 找到节点对象
    private func nodeOf(index: Int) ->Node? {
        precondition(checkIndex(index), "index 不合法")
        var findNode: Node?
        let midle:Int = count>>1
        
        if index > midle {
            findNode = last
            let end:Int = count - index - 1
            for _ in 0..<end {
                findNode = findNode?.pre
            }
            
        } else { //前半部分
            findNode = first
            for _ in 0..<index {
                findNode = findNode?.next
            }
        }
        
        return findNode
    }
    
    //检测添加操作的索引是否合法
    private func checkAddIndex(_ index: Int)->Bool {
        if index > count || index < 0 {
            return false
        }
        return true
    }
    
    //检测一般操作的索引是否合法
    private func checkIndex(_ index: Int)->Bool {
        if index >= count || index < 0 {
            return false
        }
        return true
    }
    
    func printLink() {
        var node: Node? = first
        var description = String()
        while node != nil {
            
            //打印前驱
            if node?.pre != nil {
                description += "\(node!.pre!.element)_"
            } else {
                description += "nil_"
            }
            
            //打印元素
            description += "[\(node!.element)]"
            
            //打印后继
            if node!.next != nil {
                description += "_\(node!.next!.element)   "
            } else {
                description += "_nil"
            }
            node = node!.next
            
            if node === first {
                break
            }
        }
        print(description)
    }
    
    static func test() {
        let linkList = CircleDoubleLInkList<Int>()
        //添加元素
        //期望：5_[7]_6   7_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_5   4_[5]_7
        linkList.add(index: 0, element: 1)
        linkList.printLink()
        linkList.add(index: 1, element: 2)
        linkList.printLink()
        linkList.add(index: 2, element: 3)
        linkList.printLink()
        linkList.add(index: 3, element: 4)
        linkList.printLink()
        linkList.add(index: 4, element: 5)
        linkList.printLink()
        linkList.add(index: 0, element: 6)
        linkList.printLink()
        linkList.add(index: 0, element: 7)
        linkList.printLink()
        
        //测试 nodeOf函数
        //5_[7]_6   7_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_5   4_[5]_7
        if let node = linkList.nodeOf(index: 0) {
            print(node.element)
        }
        if let node = linkList.nodeOf(index: 1) {
            print(node.element)
        }
        if let node = linkList.nodeOf(index: 2) {
            print(node.element)
        }
        if let node = linkList.nodeOf(index: 3) {
            print(node.element)
        }
        if let node = linkList.nodeOf(index: 4) {
            print(node.element)
        }
        if let node = linkList.nodeOf(index: 5) {
            print(node.element)
        }
        if let node = linkList.nodeOf(index: 6) {
            print(node.element)
        }
        
        
        
        //测试是否包含
        print("包含 5的结果：\(linkList.contains(5))")
        print("包含 7的结果：\(linkList.contains(7))")
        print("包含 3的结果：\(linkList.contains(3))")
        print("包含 8的结果：\(linkList.contains(8))")
        
        //测试删除元素5
        // 初始：5_[7]_6   7_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_5   4_[5]_7
        // 期望：4_[7]_6   7_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_7
        if let remove = linkList.remove(index: 6) {
            print("删除元素 \(remove)")
        }
        linkList.printLink()
        
        
        //初始：5_[7]_6   7_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_7
        //期望：4_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_6
        if let remove = linkList.remove(index: 0) {
            print("删除元素 \(remove)")
        }
        linkList.printLink()
        
        //初始：4_[6]_1   6_[1]_2   1_[2]_3   2_[3]_4   3_[4]_6
        //期望：4_[6]_1   6_[1]_3   1_[3]_4   3_[4]_6
        if let remove = linkList.remove(index: 2) {
            print("删除元素 \(remove)")
        }
        linkList.printLink()
        
        
        //查找索引测试 期望为3
        //当前：4_[6]_1   6_[1]_3   1_[3]_4   3_[4]_6
        //期望：3
        if let index = linkList.indexOf(element: 4) {
            print("元素4 的所有为：\(index)")
        }
        
        //查找索引测试 期望为0
        //当前：4_[6]_1   6_[1]_3   1_[3]_4   3_[4]_6
        //期望：0
        if let index = linkList.indexOf(element: 6) {
            print("元素6 的所有为：\(index)")
        }
        
        //测试设置
        //当前：4_[6]_1   6_[1]_3   1_[3]_4   3_[4]_6
        //期望：4_[6]_1   6_[1]_8   1_[8]_4   8_[4]_6
        
        if let preElement = linkList.set(index: 2, element: 8) {
            print("set：\(preElement)")
            linkList.printLink()
        }
        
        //clear 测试
        print("开始测试clear")
        linkList.clear()
        linkList.printLink()
    }
}
