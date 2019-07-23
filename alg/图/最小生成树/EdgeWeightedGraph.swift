//
//  EdgeWeightedGraph.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

let TinyEWG = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/Resource/tinyEWG.txt"
//带权重的无向图

class EdgeWeightedGraph {
    var _vertex: Int  //顶点的个数
    var _edges: Int //边的个数
    var _adj: [[Edge]] //邻接表
    init(vertex: Int) {
        self._vertex = vertex
        self._edges = 0
        self._adj = [[Edge]](repeating: [Edge](), count: vertex)
    }
    
    convenience init?(inStream: ReadFile) {
        let v = inStream.readInt()
        if v != nil {
            self.init(vertex: v!)
        } else {
            return nil
        }
        let edge = inStream.readInt()
        if edge != nil {
            for _ in 0..<edge! {
                let v = inStream.readInt()
                let w = inStream.readInt()
                let weight = inStream.readDouble()
                if v != nil && w != nil && weight != nil {
                    let edge = Edge(v: v!, w: w!, weight: weight!)
                    self.addEdge(edge)
                } else {
                    return nil
                }
            }
        } else {
            return nil
        }
    }
    
    func v() -> Int { //返回顶点数
        return self._vertex
    }
    
    func e() -> Int {  //返回边数
        return self._edges
    }
    func addEdge(_ edge: Edge) {
        let v = edge.either()
        let w = try! edge.other(v)
        self._adj[v].insert(edge, at: 0)
        self._adj[w].insert(edge, at: 0)
        self._edges += 1
    }
    
    func adj(_ v: Int) -> [Edge] {
        return self._adj[v]
    }
    
    func edges() -> [Edge] { //枚举所有的边
        var result = [Edge]()
        for v in 0..<self._vertex {
            for e in self.adj(v) {
                if try! e.other(v) > v {
                    result.insert(e, at: 0)
                }
            }
        }
        return result
    }
    
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
    
    static func test() {
        let path = TinyEWG
        let file = ReadFile(fileName: path)
        guard  file != nil else {
            print("建立文件失败！！！")
            return
        }
        
        let edgeGraph = EdgeWeightedGraph(inStream: file!)
        guard edgeGraph != nil else {
            print("建立图失败")
            return
        }
        
        let result = edgeGraph!.toString()
        print(result)
    }
}
