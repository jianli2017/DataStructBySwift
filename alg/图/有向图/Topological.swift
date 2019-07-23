//
//  Topological.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Topological {
    var _order: [Int]?
    init(graph: Digraph) {
        let cycle = DirectedCycle(graph: graph)
        if !cycle.hasCycle() {
            let dfs = DepthFirstOrder(graph: graph)
            self._order = dfs.reversePost()
        }
    }
    
    func order() -> [Int]? {
        return self._order
    }
    
    func isDAG() -> Bool {
        return self._order != nil
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
        
        print("开始测试拓扑排序......")
        let topo = Topological(graph: digraph!)
        
        if topo.isDAG() {
            print(topo.order()!)
        } else {
            print("没有输出拓扑排序")
        }
        
        
        print("输出图片数据：")
        let result = digraph!.toString()
        print(result)
    }
    
}
