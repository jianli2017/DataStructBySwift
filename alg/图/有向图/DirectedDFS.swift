//
//  DirectedDFS.swift
//  DataStruct
//
//  Created by lijian on 2019/7/22.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

//有向图的深度优先级搜索

class DirectedDFS {
    var _marked: [Bool]  // 标记节点是否调用过dfs， 索引是顶点
    
    init(graph: Digraph, s: Int) {
        self._marked = [Bool](repeating: false, count: graph.v())
        dfs(graph, s)
    }
    
    init(graph: Digraph, sources: [Int]) {
        self._marked = [Bool](repeating: false, count: graph.v())
        for s in sources {
            if !self._marked[s] {
                dfs(graph, s)
            }
        }
    }
    
    func dfs(_ graph: Digraph,_ v: Int)  {
        self._marked[v] = true
        for w in graph.adj(v) {
            if !self._marked[w] {
                dfs(graph, w)
            }
        }
    }
    
    func marked(_ v: Int) -> Bool {
        return self._marked[v]
    }
    
    static func test() {
        let path = G_TinyDG_TXT
        let file = ReadFile(fileName: path)
        guard file != nil else {
            return
        }
        let digraph = Digraph(inStream: file!)
        guard digraph != nil else {
            return
        }
        
        print("测试顶点1的连通性")
        var reachable = DirectedDFS(graph: digraph!, sources: [1])
        
        for v in 0..<digraph!.v() {
            if reachable.marked(v) {
                print("\(v)", separator: "", terminator: " ")
            }
        }
        print(" ")
        
        
        print("测试顶点2的连通性")
        reachable = DirectedDFS(graph: digraph!, sources: [2])
        
        for v in 0..<digraph!.v() {
            if reachable.marked(v) {
                print("\(v)", separator: "", terminator: " ")
            }
        }
        print(" ")
        
        
        print("测试顶点1,2,6的连通性")
        reachable = DirectedDFS(graph: digraph!, sources: [1,2,6])
        
        for v in 0..<digraph!.v() {
            if reachable.marked(v) {
                print("\(v)", separator: "", terminator: " ")
            }
        }
        print(" ")
        
        
        print("输出图片数据：")
        let result = digraph!.toString()
        print(result)
    }
}
