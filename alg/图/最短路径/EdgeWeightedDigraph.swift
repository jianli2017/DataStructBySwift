//
//  EdgeWeightedDigraph.swift
//  DataStruct
//
//  Created by lijian on 2019/7/25.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

let TinyEWD = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/Resource/tinyEWD.txt"
//带权重的无向图

class EdgeWeightedDigraph {
    var _vertex: Int  //顶点的个数
    var _edges: Int //边的个数
    var _adj: [[DirectedEdge]] //邻接表
    init(vertex: Int) {
        self._vertex = vertex
        self._edges = 0
        self._adj = [[DirectedEdge]](repeating: [DirectedEdge](), count: vertex)
    }
    
    convenience init?(inStream: ReadFile) {
        let v = inStream.readInt()
        if v != nil {
            self.init(vertex: v!)
        } else {
            return nil
        }
        let edge = inStream.readInt()  //读取边数
        guard edge != nil else {
            return nil
        }
        for _ in 0..<edge! {
            let v = inStream.readInt()
            let w = inStream.readInt()
            let weight = inStream.readDouble()
            if v != nil && w != nil && weight != nil {
                let edge = DirectedEdge(v: v!, w: w!, weight: weight!)
                self.addEdge(edge)
            } else {
                return nil
            }
        }
    }
    
    func v() -> Int { //返回顶点数
        return self._vertex
    }
    
    func e() -> Int {  //返回边数
        return self._edges
    }
    func addEdge(_ edge: DirectedEdge) {
        self._adj[edge.form()].insert(edge, at: 0)
        self._edges += 1
    }
    
    func adj(_ v: Int) -> [DirectedEdge] {
        return self._adj[v]
    }
    
    func edges() -> [DirectedEdge] { //枚举所有的边
        var result = [DirectedEdge]()
        for v in 0..<self._vertex {
            for e in self.adj(v) {
                result.insert(e, at: 0)
            }
        }
        return result
    }
}

extension EdgeWeightedDigraph {
    func toString() -> String {
        var result: String  =
        """
        \(self.v()) vertixes \(self.e()) edges \n
        """
        for i in 0..<self.v() {
            result += "\(i) :"
            for w in self.adj(i) {
                result += "\(w.toString())   "
            }
            result +=
            """
            \n
            """
        }
        return result
    }
}

extension EdgeWeightedDigraph {
    static func test() {
        let path = TinyEWD
        let file = ReadFile(fileName: path)
        guard  file != nil else {
            print("建立文件失败！！！")
            return
        }
        
        let edgeGraph = EdgeWeightedDigraph(inStream: file!)
        guard edgeGraph != nil else {
            print("建立图失败")
            return
        }
        
        let result = edgeGraph!.toString()
        print(result)
    }
}

