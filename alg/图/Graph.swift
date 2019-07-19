//
//  Graph.swift
//  DataStruct
//
//  Created by lijian on 2019/7/19.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Graph {
    var vertex: Int
    var adj: [[Int]]
    var edge: Int = 0
    
    init(vertex: Int) {
        self.vertex = vertex
        adj = [[Int]](repeating: [Int](), count: vertex)
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
                self.addEdge(v!, w!)
            }
        } else {
            return nil
        }
    }
    
    func addEdge(_ v: Int, _ w: Int) {
        self.adj[v].append(w)
        self.adj[w].append(v)
        self.edge += 1
    }
    
    func V() -> Int {
        return vertex
    }
    
    func E() -> Int {
        return edge
    }
    func toString() -> String {
        var result: String  =
        """
        \(V) vertixes \(E) edges \n
        """
        for i in 0..<vertex {
            result += "\(i) :"
            for w in adj[i] {
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
        let path = "/Users/lijian/Desktop/数据结构学习/DataStruct/alg/图/tiny.txt"
        let file = ReadFile(fileName: path)
        if file != nil {
            let graph = Graph(inStream: file!)
            if graph != nil {
                let result = graph!.toString()
                print(result)
            }
        }
    }
}
