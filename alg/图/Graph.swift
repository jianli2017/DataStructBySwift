//
//  Graph.swift
//  DataStruct
//
//  Created by lijian on 2019/7/19.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

let GraphFileName = "/Users/lijian/Desktop/github/DataStructBySwift/alg/图/tiny.txt"


class Graph {
    var _vertex: Int
    var _adjoin: [[Int]]
    var _edge: Int = 0
    
    init(vertex: Int) {
        self._vertex = vertex
        _adjoin = [[Int]](repeating: [Int](), count: vertex)
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
        self._adjoin[v].append(w)
        self._adjoin[w].append(v)
        self._edge += 1
    }
    
    func V() -> Int {
        return _vertex
    }
    
    func E() -> Int {
        return _edge
    }
    
    func adj(_ v: Int) -> [Int] {
        return _adjoin[v]
    }
    func toString() -> String {
        var result: String  =
        """
        \(V) vertixes \(E) edges \n
        """
        for i in 0..<_vertex {
            result += "\(i) :"
            for w in _adjoin[i] {
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
        let path = GraphFileName
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
