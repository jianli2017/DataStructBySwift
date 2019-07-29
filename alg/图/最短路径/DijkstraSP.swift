//
//  Dijkstra.swift
//  DataStruct
//
//  Created by lijian on 2019/7/25.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation
class DijkstraSP {
    var edgeTo: [DirectedEdge] //保存路径树，只是和索引顶点连接的父节点对象
    var distTo: [Double] //所以是顶点， 顶点到起点的距离
    var pq: IndexMinPQ<Double>
    let s: Int
    
    init(graph: EdgeWeightedDigraph, s: Int) {
        let vertexCount = graph.v()
        self.edgeTo = [DirectedEdge](repeating: DirectedEdge(), count: vertexCount)
        self.distTo = [Double](repeating: Double(Int.max), count: vertexCount)
        pq = IndexMinPQ<Double>(maxN: vertexCount)!
        self.s = s
        //第二阶段构造
        distTo[s] = 0.0
        try! pq.insert(index: s, forKey: 0.0)
        while !pq.isEmpty() {
            relax(graph,try! pq.delMin())
        }
    }
    
    func relax(_ edge: DirectedEdge)  {  //边的松弛
        let v = edge.form()
        let w = edge.to()
        if distTo[w] > distTo[v] + edge.weight() {
            distTo[w] = distTo[v] + edge.weight()
            edgeTo[w] = edge
        }
    }
    
    func relax(_ graph: EdgeWeightedDigraph, _ v: Int)  { //顶点的松弛
        for edge in graph.adj(v) {
            let w = edge.to()
            if distTo[w] > distTo[v] + edge.weight() {
                distTo[w] = distTo[v] + edge.weight()
                edgeTo[w] = edge
                if pq.contains(w) {
                    try! pq.changeKey(index: w, forKey: distTo[w])
                } else {
                    try! pq.insert(index: w, forKey: distTo[w])
                }
            }
        }
    }
    
    func distTo(_ v: Int) -> Double {
        return distTo[v]
    }
    
    func hasPathTo(_ v: Int) -> Bool {
        return distTo[v] < Double(Int.max)
    }
    
    func pathTo(_ v: Int) -> [DirectedEdge]? {
        if !hasPathTo(v) {
            return nil
        }
        let path = Stack<DirectedEdge>()
        var x = edgeTo[v]
        repeat {
            path.push(x)
            x =  edgeTo[x.form()]
        } while x.form() != self.s
        path.push(x)  //添加第一条路径
        return path.iterater()
    }
}


extension DijkstraSP {
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
        
        print("打印带权重的树.....")
        let result = edgeGraph!.toString()
        print(result)
        
        print("打印最短路径.....")
        let sp = DijkstraSP(graph: edgeGraph!, s: 0)
        
        for v in 0..<edgeGraph!.v() {
            if !sp.hasPathTo(v) {
                continue
            }
            print("\(0) to \(v): （\(sp.distTo(v))）", separator: "", terminator: " ")
            for x in sp.pathTo(v)! {
                print("\(x.toString())", separator: "", terminator: " ")
            }
            print()
        }
        
    }
}
