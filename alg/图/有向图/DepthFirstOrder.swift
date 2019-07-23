//
//  DepthFirstOrder.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
let G_TinyDG_Topo_TXT = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/Resource/tinyDG_Topo.txt"

class DepthFirstOrder {
    var _marked:[Bool]
    var _pre: Queue<Int>
    var _post: Queue<Int>
    var _reversePost: Stack<Int>
    
    init(graph: Digraph) {
        _pre = Queue<Int>()
        _post = Queue<Int>()
        _reversePost = Stack<Int>()
        let vertexCount = graph.v()
        _marked = [Bool](repeating: false, count: vertexCount)
        for v in 0..<vertexCount {
            if !self._marked[v] {
                dfs(graph, v)
            }
        }
    }
    
    func dfs(_ graph: Digraph,_ v: Int)  {
        self._pre.enqueue(v)
        self._marked[v] = true
        for w in graph.adj(v) {
            if !self._marked[w] {
                dfs(graph, w)
            }
        }
        self._post.enqueue(v)
        self._reversePost.push(v)
    }
    
    func pre() -> [Int] {
        return self._pre.iterater()
    }
    
    func post() -> [Int] {
        return self._post.iterater()
    }
    
    func reversePost() -> [Int] {
        return self._reversePost.iterater()
    }
    static func test() {
        let path = G_TinyDG_Topo_TXT
        let file = ReadFile(fileName: path)
        guard file != nil else {
            return
        }
        let digraph = Digraph(inStream: file!)
        guard digraph != nil else {
            return
        }
        
        print("开始测试遍历......")
        let order = DepthFirstOrder(graph: digraph!)
        
        print("前序遍历：")
        print(order.pre())
        
        print("后续遍历：")
        print(order.post())
        
        print("逆后续遍历：")
        print(order.reversePost())
        
        print("输出图片数据：")
        let result = digraph!.toString()
        print(result)
    }
}
