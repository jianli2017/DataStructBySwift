//
//  Digraph.swift
//  DataStruct
//
//  Created by lijian on 2019/7/22.
//  Copyright © 2019 lijian. All rights reserved.
//
//有向图数据结构

let G_TinyDG_TXT = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/Resource/tinyDG.txt"

import Foundation

class Digraph {
    let _vertex: Int //顶点个数
    var _edges: Int = 0  //边数
    var _adj:[[Int]] //邻接表二维数组
    init(v: Int) {
        self._vertex = v
        self._adj = [[Int]](repeating: [Int](), count: v)
    }

    func v() -> Int {  //返回顶点的个数
        return self._vertex
    }
    
    func e() -> Int {  //返回边的个数
        return self._edges
    }
    
    func addEdge(_ v: Int, _ w:Int )  {  //添加v->w的边
        self._adj[v].insert(w, at: 0)
        self._edges += 1
    }
    
    func adj(_ v: Int) -> [Int] {  //返回顶点v的邻接表
        return self._adj[v]
    }
    
    func reverse() -> Digraph {
        let r = Digraph(v: self.v())
        for v in 0..<self.v() {
            for w in self.adj(v)  {
                r.addEdge(v, w)
            }
        }
        return r
    }
    
    convenience init?(inStream: ReadFile) {
        let v = inStream.readInt()
        if v != nil {
            self.init(v: v!)
        } else {
            return nil
        }
        let edge = inStream.readInt()
        if edge != nil {
            for _ in 0..<edge! {
                let v = inStream.readInt()
                let w = inStream.readInt()
                self.addEdge(v!, w!)
            }
        } else {
            return nil
        }
    }
    
    func toString() -> String {
        var result: String  =
        """
        \(self.v()) vertixes \(self.e()) edges \n
        """
        for i in 0..<self.v() {
            result += "\(i) :"
            for w in self.adj(i) {
                result += "\(w) "
            }
            result +=
            """
            \n
            """
        }
        return result
    }
    
    static func testReadGraph() {
        let path = G_TinyDG_TXT
        let file = ReadFile(fileName: path)
        if file != nil {
            let digraph = Digraph(inStream: file!)
            if digraph != nil {
                let result = digraph!.toString()
                print(result)
            }
        }
    }
}
