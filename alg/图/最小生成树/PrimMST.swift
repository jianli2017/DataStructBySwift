//
//  PrimMST.swift
//  DataStruct
//
//  Created by lijian on 2019/7/24.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
extension Double: RequireInit {}
//Prim算法的即时版本
class PrimMST {
    var edgeTo: [Edge] //保存最小生成树的顶点列表，索引顶点，值到该顶点的边
    var distTo: [Double] //保存边的距离
    var marked: [Bool]  //if true on tree
    var pq: IndexMinPQ<Double>
    
    init(graph: EdgeWeightedGraph) {
        let vertexCount = graph.v()
        edgeTo = [Edge](repeating: Edge(), count: vertexCount)
        distTo = [Double](repeating: Double(Int.max), count: vertexCount)
        marked = [Bool](repeating: false, count: vertexCount)
        pq = IndexMinPQ<Double>(maxN: vertexCount)!
        distTo[0] = 0.0
        try! pq.insert(index: 0, forKey: 0.0)
        while !pq.isEmpty() {
            visit(graph: graph, v: try! pq.delMin())
        }
    }
    
    func visit(graph: EdgeWeightedGraph, v:Int)  {
        marked[v] = true
        for edge in graph.adj(v) {
            let w = try! edge.other(v)
            if marked[w] { continue } //跳过失效的边
            if edge.weight() < distTo[w] {
                edgeTo[w] = edge // Edge e is new best connection from tree to w.
                distTo[w] = edge.weight()
                
                if pq.contains(w) {
                    try! pq.changeKey(index: w, forKey: distTo[w])
                } else {
                    try! pq.insert(index: w, forKey: distTo[w])
                }
            }
        }
    }
    
    func edges() -> [Edge] {
        return edgeTo
    }
}

extension PrimMST {
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
        
        print("打印带权重的树.....")
        let result = edgeGraph!.toString()
        print(result)
        
        print("打印最小生成树.....")
        let mst = PrimMST(graph: edgeGraph!)
        for edge in mst.edges() {
            print("\(edge.toString())")
        }
    }
}
