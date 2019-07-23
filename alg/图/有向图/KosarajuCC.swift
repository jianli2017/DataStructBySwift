//
//  KosarajuCC.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
class KosarajuCC {
    var _marked: [Bool]  //已达顶点
    var _id: [Int]  //分量标识，索引顶点，值是连通分量标识
    var _count = 0  //分量个数
    init(graph: Digraph) {
        let vertexCount = graph.v()
        self._marked = [Bool](repeating: false, count: vertexCount)
        self._id = [Int](repeating: 0, count: vertexCount)
        
        let order = DepthFirstOrder(graph: graph.reverse())
        for s in order.reversePost() {
            if !_marked[s] {
                dfs(graph, s)
                self._count += 1
            }
        }
    }
    
    func dfs(_ G: Digraph, _ v: Int)  {
        self._marked[v] = true
        self._id[v] = self._count
        for w in G.adj(v) {
            if !self._marked[w] {
                dfs(G, w)
            }
        }
    }
    
    func stronglyConnected(_ v: Int, _ w: Int) -> Bool { //判断两个顶点是否连通
        return self._id[v] == self._id[w]
    }
    
    func id(_ v: Int) -> Int { //返回顶点属于的连通分量
        return self._id[v]
    }
    
    func count() -> Int { //返回连通分量的个数
        return self._count
    }
    
    static func test() {
        let path = G_TinyDG_TXT
        let file = ReadFile(fileName: path)
        
        guard file != nil else {
            print("失败，file为空")
            return
        }
        
        let graph = Digraph(inStream: file!)
        guard graph != nil else {
            print("失败，graph为空")
            return
        }
        
        //打印树
        let result = graph!.toString()
        print(result)
        
        //打印反置树
        let reverse = graph!.reverse().toString()
        print(reverse)
        
        let cc = KosarajuCC(graph: graph!)
        let m = cc.count()  //获取连通分量的个数
        print("连通分量的个数：\(m)")
        
        
        var component = [[Int]](repeating: [Int](), count: m)  //构造连通分量数据
        for i in 0..<graph!.v() {
            component[cc.id(i)].append(i)
        }
        
        //打印
        for i in 0..<m {
            for v in component[i] {
                print("\(v) ", separator: "", terminator: " ")
            }
            print("")
        }
    }
}
