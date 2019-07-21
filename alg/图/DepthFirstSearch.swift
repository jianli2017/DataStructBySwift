//
//  DepthFirstSearch.swift
//  DataStruct
//
//  Created by lijian on 2019/7/20.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class DepthFirstSearch {
    private var _marked: [Bool]  //描述标记过的顶点
    private var _count: Int = 0  //描述标记过的顶点个数
    
    init(G: Graph, s: Int ) {
        _marked = [Bool](repeating: false, count: G.V() )
        dfs(G, s)
    }
    
    func dfs(_ G: Graph, _ v: Int)  {
        _marked[v] = true
        _count += 1
        for w in G.adj(v) {
            if _marked[w] == false {
                dfs(G, w)
            }
        }
    }
    
    func marked(_ v: Int) -> Bool {
        return _marked[v]
    }
    
    func count() -> Int {
        return _count
    }
}
