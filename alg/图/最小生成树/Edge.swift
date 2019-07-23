//
//  Edge.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

enum EdgeError: Error {
    case invalidEdge(egdg: Int)
}
class Edge :Comparable {
    let _v: Int
    let _w: Int
    let _weight: Double
    
    init(v: Int, w: Int, weight: Double) {
        self._v = v
        self._w = w
        self._weight = weight
    }
    
    func weight() -> Double {  //返回权重
        return self._weight
    }
    
    func either() -> Int { //返回任意一个顶点
        return self._v
    }
    
    func other(_ v: Int) throws -> Int { //返回另一个顶点
        if self._v == v {
            return self._w
        } else if (self._w == v) {
            return self._v
        } else {
            print("取顶点错误")
            throw EdgeError.invalidEdge(egdg: v)
        }
    }
    
    static func < (lhs: Edge, rhs: Edge) -> Bool {
        if lhs._weight < rhs._weight {
            return true
        }
        return false
    }
    
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        if  lhs._weight == rhs._weight {
            return true
        }
        return false
    }
    
    func toString() -> String {
        return String.init(format: "%d,%d,%.2f", self._v, self._w, self._weight)
    }
}
