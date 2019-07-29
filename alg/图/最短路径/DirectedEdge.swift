//
//  DirectedEdge.swift
//  DataStruct
//
//  Created by lijian on 2019/7/25.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class DirectedEdge :Comparable {
    let _v: Int
    let _w: Int
    let _weight: Double
    
    init() {
        self._v = 0
        self._w = 0
        self._weight = 0
    }
    
    init(v: Int, w: Int, weight: Double) {
        self._v = v
        self._w = w
        self._weight = weight
    }
    
    func weight() -> Double {  //返回权重
        return self._weight
    }
    
    func form() -> Int { //返回出发顶点
        return self._v
    }
    
    func to() -> Int { //返回结束顶点
        return self._w
    }
    
    static func < (lhs: DirectedEdge, rhs: DirectedEdge) -> Bool {
        if lhs._weight < rhs._weight {
            return true
        }
        return false
    }
    
    static func == (lhs: DirectedEdge, rhs: DirectedEdge) -> Bool {
        if  lhs._weight == rhs._weight {
            return true
        }
        return false
    }
    
    func toString() -> String {
        return String.init(format: "%d,%d,%.2f", self._v, self._w, self._weight)
    }
}
