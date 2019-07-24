//
//  LazyPrimMST.swift
//  DataStruct
//
//  Created by lijian on 2019/7/24.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

//延时版本的Prim 最小生成树算法

class LazyPrimMST {
    var _marked: [Bool]  //标记是否加入最小生成树中
    var _mst: Queue<Edge>
    var _pq: MinPQ<Edge>
    
    init(graph: EdgeWeightedGraph) {
        let vertexCount = graph.v()
        self._marked = [Bool](repeating: false, count: vertexCount)
        self._mst = Queue<Edge>()
        self._pq = MinPQ<Edge>(priorityFunction: {  //优先队列，小的优先级高
            return $0 < $1
        })
        
        //第二阶段了 ，自定义操作
        visit(graph, 0) //将顶点0的邻接表添加到优先队列中
        
        while !self._pq.isEmpty {
            let e = self._pq.dequeue()!  //从优先队列中取出一条边
            let v = e.either()
            let w = try! e.other(v)
            if self._marked[v] && self._marked[w] { //如果两个顶点都在树上，那么边是失效的
                continue
            }
            
            self._mst.enqueue(e)
            if !self._marked[v] {
                self.visit(graph, v)
            }
            
            if !self._marked[w] {
                self.visit(graph, w)
            }
        }
    }
    
    func visit(_ graph: EdgeWeightedGraph, _ v: Int) {
        self._marked[v] = true
        for edge in graph.adj(v) {
            if !self._marked[try! edge.other(v)] {
                _pq.equeue(edge)
            }
        }
    }
    
    func edges() -> [Edge] {  //返回最小生成树的边的列表
        return self._mst.iterater()
    }
}
extension LazyPrimMST {
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
        let mst = LazyPrimMST(graph: edgeGraph!)
        for edge in mst.edges() {
            print("\(edge.toString())")
        }
    }
}
