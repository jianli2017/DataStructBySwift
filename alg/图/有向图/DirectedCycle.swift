//
//  DirectedCycle.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

let G_TinyDG_Cycle1_TXT = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/Resource/tinyDG_Cycle1.txt"
let G_TinyDG_Cycle2_TXT = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/Resource/tinyDG_Cycle2.txt"



class DirectedCycle {
    var _marked: [Bool]
    var _edgeTo: [Int]
    var _cycle: Stack<Int>?
    var _onStack: [Bool]
    init(graph: Digraph) {
        let vertexCount = graph.v()
        self._marked = [Bool](repeating: false, count: vertexCount)
        self._edgeTo = [Int](repeating: 0, count: vertexCount)
        self._onStack = [Bool](repeating: false, count: vertexCount)
        
        for v in 0..<vertexCount {
            if !self._marked[v] {
                dfs(graph, v)
            }
        }
    }
    
    func dfs(_ graph: Digraph, _ v: Int)  {
        self._onStack[v] = true
        self._marked[v] = true
        for w in graph.adj(v) {
            if !self._marked[w] {  //如果没有标记，递归标记（这里不需要判断换，没有标记过，肯定不在调用栈上）
                self._edgeTo[w] = v
                dfs(graph, w)
            } else { //标记过了，可以判断这个顶点是否在栈上
                if self._onStack[w] { //有环
                    self._cycle = Stack<Int>()
                    var x = v
                    repeat {
                        self._cycle?.push(x)
                        x = self._edgeTo[x]
                    } while x != w
                    
                    self._cycle?.push(w)
                    self._cycle?.push(v)
                }
            }
        }
        self._onStack[v] = false
    }
    
    func hasCycle() -> Bool {
        return self._cycle != nil
    }
    
    func cycle() -> [Int] {
        if self.hasCycle() {
            return self._cycle!.iterater()
        } else {
            return [Int]()
        }
    }
    
    static func test1() {
        let path = G_TinyDG_Cycle1_TXT
        let file = ReadFile(fileName: path)
        guard file != nil else {
            return
        }
        let digraph = Digraph(inStream: file!)
        guard digraph != nil else {
            return
        }
        
        print("开始测试是否有环......")
        let cycle = DirectedCycle(graph: digraph!)
        if cycle.hasCycle() {
            print("有环")
            print(cycle.cycle())
        } else {
            print("无环")
        }
      

        print("输出图片数据：")
        let result = digraph!.toString()
        print(result)
    }
    
    static func test2() {
        let path = G_TinyDG_Cycle2_TXT
        let file = ReadFile(fileName: path)
        guard file != nil else {
            return
        }
        let digraph = Digraph(inStream: file!)
        guard digraph != nil else {
            return
        }
        
        print("开始测试是否有环......")
        let cycle = DirectedCycle(graph: digraph!)
        if cycle.hasCycle() {
            print("有环")
            print(cycle.cycle())
        } else {
            print("无环")
        }
        
        
        print("输出图片数据：")
        let result = digraph!.toString()
        print(result)
    }
}

