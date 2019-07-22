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
            if self._marked[w] == false {
                self._edgeTo[w] = v
                dfs(G, v: w)
            }
        }
    }
    
    func hasPathTo(_ v: Int) -> Bool {
        return self._marked[v]
    }
    
    func pathTo(_ v: Int) -> [Int]? {
        if !hasPathTo(v) {
            return nil
        }
        var path = [Int]()
        var x = v
        repeat {
            path.insert(x, at: 0)
            x =  self._edgeTo[x]
        } while x != self._s
        
        path.insert(self._s, at: 0)
        return path
    }
    
    static func test() {
        let path = G_TinyGG_TXT
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
        
        
        let s = 0
        let dfsPath = DepthFirstPaths(G: graph!, s: s)
        for v in 0..<graph!.V() {
            if !dfsPath.hasPathTo(v) {
                continue
            }
            print("\(s) to \(v):", separator: "", terminator: " ")
            for x in dfsPath.pathTo(v)! {
                if x == s {
                    print("\(x)", separator: "", terminator: " ")
                } else {
                    print("\(x)", separator: "", terminator: " ")
                }
            }
            print()
        }
    }
}
