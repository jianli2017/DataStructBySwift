//
//  IndexMinPQ.swift
//  DataStruct
//
//  Created by lijian on 2019/7/24.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

enum IndexMinPQError: Error {
    case IndexMinPQContainedError
    
    case IndexMinPQOutRangeError
}

protocol RequireInit  {  //key必须提供一个默认实现
     init()
}

//假设外部索引是outIndex
struct IndexMinPQ<Key> where Key:Comparable & RequireInit  {
    let maxN: Int  //优先队列的最大容量
    var n: Int     //优先队列的当前容量
    var pq: [Int]  //优先队列,值存储是 outIndex
    var qp: [Int]  //索引是 outIndex，值是存储的优先队列的所有
    var keys: [Key]
    
    init?(maxN: Int) {
        if maxN < 0 {return nil}
        self.maxN = maxN + 1
        self.n = 0
        self.qp = [Int](repeating: -1, count: maxN + 1)
        self.pq = [Int](repeating: -1, count: maxN + 1)  //这个优先队列0位置没有使用
        self.keys = [Key](repeating: Key(), count: maxN + 1)
    }
    
    func isEmpty() -> Bool { //判断是否为空
        return n==0
    }
    
    func contains(_ i: Int) -> Bool {
        if i<0 || i>maxN {
            return false
        }
        return qp[i] != -1
    }
    
    func size() -> Int {
        return n
    }
    
    mutating func insert(index i: Int, forKey key: Key) throws {
        guard i >= 0 && i < maxN else {
            throw IndexMinPQError.IndexMinPQOutRangeError
        }
        guard !self.contains(i) else {
            throw IndexMinPQError.IndexMinPQContainedError
        }
        self.n += 1
        self.qp[i] = n  //qp的值是pq的索引
        self.pq[n] = i  //pq中存储的是qp的所用
        self.keys[i] = key
        self.swim(n)  //插入完，上浮
    }
    
    func minIndex() throws  -> Int  {
        guard n != 0 else {
            throw IndexMinPQError.IndexMinPQOutRangeError
        }
        return self.pq[1]
    }
    
    func minKey() throws  -> Key  {
        guard n != 0 else {
            throw IndexMinPQError.IndexMinPQOutRangeError
        }
        return self.keys[pq[1]]
    }
    
    mutating func delMin() throws ->Int {
        guard n != 0 else {
            throw IndexMinPQError.IndexMinPQOutRangeError
        }
        
        let min = pq[1]
        self.exch(1, self.n)  //将最后一个交换到第一位
        self.n -= 1
        self.sink(1)  //位置1的元素开始下层
        
        self.qp[min] = -1 //qp 恢复原样
        self.keys[min] = Key()
        self.pq[self.n+1] = -1
        return min;
    }
    
    func keyOf(index i: Int) throws -> Key {
        guard i >= 0 && i < maxN else {
            throw IndexMinPQError.IndexMinPQOutRangeError
        }
        guard !self.contains(i) else {
            throw IndexMinPQError.IndexMinPQContainedError
        }
        return keys[i]
    }
    
    mutating func changeKey(index i: Int, forKey key: Key) throws {
        guard i >= 0 && i < maxN else {
            throw IndexMinPQError.IndexMinPQOutRangeError
        }
        guard self.contains(i) else {
            throw IndexMinPQError.IndexMinPQContainedError
        }
        self.keys[i] = key
        swim(qp[i])  //先上浮
        sink(qp[i]) //
    }
}

extension IndexMinPQ {
    func greater(_ i: Int, _ j: Int) -> Bool {
        return self.keys[pq[i]] > self.keys[pq[j]]
    }
    
    mutating func exch(_ i: Int, _ j: Int) {
        let swap = pq[i]
        pq[i] = pq[j]
        pq[j] = swap
        qp[pq[i]] = i
        qp[pq[j]] = j
    }
    mutating func swim(_ k: Int)  {  //上浮 ，不断的和父节点比较，如果父节点大，交换
        var i = k
        while  i > 1 && greater( i/2,  i) {
            exch( i, i/2)
            i = i/2
        }
    }
    mutating func sink(_ k: Int) { //下沉
        var _k = k
        while _k*2 <= n {
            var j = 2*_k  //左子节点
            if j < n && greater(j, j+1) {j=j+1}  //找出左右节点中大的那个，这里j<n  做了越界判断  j+1 正好是n，不会越界
            if !greater(_k, j) { break } //如果父节点小于等于子节点中的最大的， 符合最小优先队列的要求，退出
            
            self.exch( _k, j)
            _k = j  //索引继续往下递归
        }
    }
}

extension String : RequireInit {}
extension IndexMinPQ {
    static func test() {
        let strings = ["it", "was", "the", "best", "of", "times", "it", "was", "the", "worst"]
        var pq:IndexMinPQ<String> =  IndexMinPQ<String>(maxN: strings.count)!
        
        for i in 0..<strings.count {
            try! pq.insert(index: i, forKey: strings[i])
        }
        
        while !pq.isEmpty() {
            print("开始删除............")
            print(pq.keys)
            print("开始删除............")
            let i = try! pq.delMin()
            print("删除的元素 \(i)")
            
            print("删除后的结果")
            print(pq.keys)
            print("")
            print("")
        }
    }
}
