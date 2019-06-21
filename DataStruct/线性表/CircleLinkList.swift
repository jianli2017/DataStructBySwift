//
//  CircleLinkList.swift
//  DataStruct
//
//  Created by lijian on 2019/6/21.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

//循环单链表
class CircleLinkList<E : Equatable> :PrintLink, ListProtocal {
    
    //节点类，类值引用类型
    class Node {
        var element: E
        //下一个节点，可以为空，定义为可选Node
        var next: Node?
        
        init(element: E, next: Node?) {
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
        while node != nil {
            if node!.element == element {
                return true
            }
            node = node!.next
            
            if node === first { //表示循环第二轮 ，退出
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
        
        if index == 0 { //首节点添加，兼容空链表
            ///创建添加的节点
            let firstNew = Node(element: element, next: first)
            let last: Node
            if first != nil {
                last = nodeOf(index: count - 1)!
            } else {
                last = firstNew
            }
            
            last.next = firstNew
            first = firstNew
        } else {
            //查找前一个节点
            if let pre = nodeOf(index: index-1) {
                let newNode: Node = Node(element: element, next: pre.next)
                pre.next = newNode;
            }
        }
        count += 1
    }
    
    
    //删除index位置对应的元素
    func remove(index: Int)->E? {
        let removedElement: E?
        
        if index == 0 {
            removedElement = first?.element
            if count == 1 {
                first = nil
            } else {
                //计算出last
                let last: Node? = nodeOf(index: count - 1)
                first = first?.next
                last?.next = first;
            }
        } else {
            let node:Node? = nodeOf(index: index - 1)
            removedElement = node?.next?.element
            node?.next = node?.next?.next
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
        first?.next = nil;
        first = nil
        count = 0
    }
    
    //通过index 找到节点对象
    private func nodeOf(index: Int) ->Node? {
        precondition(checkIndex(index), "index 不合法")
        
        //循环查找
        var findNode: Node? = first;
        for _ in 0 ..< index {
            findNode = findNode?.next
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
            description += "[\(node!.element)]"
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
        let linkList = CircleLinkList<Int>()
        
        //测试添加
        //期望：[7]_6   [6]_1   [1]_2   [2]_3   [3]_4   [4]_5   [5]_7
        linkList.add(index: 0, element: 1)
        linkList.add(index: 1, element: 2)
        linkList.add(index: 2, element: 3)
        linkList.add(index: 3, element: 4)
        linkList.add(index: 4, element: 5)
        linkList.add(index: 0, element: 6)
        linkList.add(index: 0, element: 7)
        linkList.printLink()
        
        //测试是否包含
        print("包含 5的结果：\(linkList.contains(5))")
        print("包含 7的结果：\(linkList.contains(7))")
        print("包含 3的结果：\(linkList.contains(3))")
        print("包含 8的结果：\(linkList.contains(8))")
        
        //测试删除
        //当前：[7]_6   [6]_1   [1]_2   [2]_3   [3]_4   [4]_5   [5]_7
        //期望：[7]_6   [6]_1   [1]_2   [2]_3   [3]_4   [4]_7
        if let remove = linkList.remove(index: 6) {
            print("删除元素 \(remove)")
        }
        linkList.printLink()
        print()
        
        //当前：[7]_6   [6]_1   [1]_2   [2]_3   [3]_4   [4]_7
        //期望：[6]_1   [1]_2   [2]_3   [3]_4   [4]_6
        if let remove = linkList.remove(index: 0) {
            print("删除元素 \(remove)")
        }
        linkList.printLink()
        print()
        
        
        //当前：[6]_1   [1]_2   [2]_3   [3]_4   [4]_6
        //期望：[6]_1   [1]_3   [3]_4   [4]_6
        if let remove = linkList.remove(index: 2) {
            print("删除元素 \(remove)")
        }
        linkList.printLink()
        print()
        
        //查找索引测试
        //当前：[6]_1   [1]_3   [3]_4   [4]_6
        //期望：3
        if let index = linkList.indexOf(element: 4) {
            print("元素4 的索引为：\(index)")
        }
        
        //当前：[6]_1   [1]_3   [3]_4   [4]_6
        //期望：0
        if let index = linkList.indexOf(element: 6) {
            print("元素6 的所有为：\(index)")
        }
        
        //测试设置
        //当前：[6]_1   [1]_3   [3]_4   [4]_nil
        //期望：[6]_1   [1]_8   [8]_4   [4]_nil
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
