//
//  CC.swift
//  DataStruct
//
//  Created by lijian on 2019/7/22.
//  Copyright © 2019 lijian. All rights reserved.
//

//连通分量
import Foundation

class CC {
    var _marked: [Bool]
    var _id: [Int]
    var _count = 0
    init(G: Graph) {
        let vertexCount = G.V()
        self._marked = [Bool](repeating: false, count: vertexCount)
        self._id = [Int](repeating: 0, count: vertexCount)
        for s in 0..<vertexCount {
            if !_marked[s] {
                dfs(G, s)
                self._count += 1
            }
        }
    }
    
    func dfs(_ G: Graph, _ v: Int)  {
        self._marked[v] = true
        self._id[v] = self._count
        for w in G.adj(v) {
            if !self._marked[w] {
                dfs(G, w)
            }
        }
    }
    
    func connected(_ v: Int, _ w: Int) -> Bool { //判断两个顶点是否连通
        return self._id[v] == self._id[w]
    }
    
    func id(_ v: Int) -> Int { //返回顶点属于的连通分量
        return self._id[v]
    }
    
    func count() -> Int { //返回连通分量的个数
        return self._count
    }
    
    static func test() {
        let path = GraphFileName
        let file = ReadFile(fileName: path)
        
        guard file != nil else {
            return
        }
        
        let graph = Graph(inStream: file!)
        guard graph != nil else {
            return
        }
        
        //打印树
        let result = graph!.toString()
        print(result)
        
        let cc = CC(G: graph!)
        let m = cc.count()  //获取连通分量的个数
        print("连通分量的个数：\(m)")
        var component = [[Int]](repeating: [Int](), count: m)  //构造连通分量数据
        for i in 0..<graph!.V() {
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
