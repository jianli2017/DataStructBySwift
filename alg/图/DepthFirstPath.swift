//
//  DepthFirstPath.swift
//  DataStruct
//
//  Created by lijian on 2019/7/21.
//  Copyright © 2019 lijian. All rights reserved.
//

//使用深度优先搜索解决单点路径问题
import Foundation


class DepthFirstPaths {
    var _marked: [Bool] // 标记这个顶点调用过dfs了吗？
    var _edgeTo: [Int] //从起点到一个顶点的已知路径上的最后一个顶点
    let _s: Int // 起点
    init(G: Graph, s: Int) {
        let count = G.V()
        self._marked = [Bool](repeating: false, count: count)
        self._edgeTo = [Int](repeating: 0, count: count)
        self._s = s
        dfs(G, v: s)
    }
    
    func dfs(_ G: Graph, v: Int)  {
        _marked[v] = true
        for w in G.adj(v) {
            if !self._marked[w] {
                self._edgeTo[w] = v
                dfs(G, v: w)
            }
        }
    }
    
    func hasPathTo(_ v: Int) -> Bool {
        return self._marked[v]
    }
    
    func pathTo(v: Int) -> [Int]? {
        if !hasPathTo(v) {
            return nil
        }
        var path = [Int]()
        var x = v
        while x != self._s {
            path.insert(x, at: 0)
            x =  self._edgeTo[x]
        }
        path.insert(self._s, at: 0)
        return path
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
        let  path = DepthFirstPaths(G: graph!, s: 0)
        for i in 0..<graph!.V() {
            if search.marked(i) {
                print(i, separator: "", terminator: ",")
            }
        }
        print(" ")
        if search.count() != graph!.V() {
            print("not connet!")
        } else {
            print("connect")
        }
    }

}
