//
//  动态规划.swift
//  DataStruct
//
//  Created by lijian on 2019/7/18.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


class Problem01_BackTrace {
    var maxW = Int.min  // 结果放到 maxW 中
    let weight = [2,2,4,6,3]
    var n = 5
    var w = 9
    
    func maxWeight(i: Int,  cw: Int) {
        if cw == w || i == n { //cw==w 表示装满了，i==n 表示物品都考察完了
            if cw > maxW {
                maxW = cw  //更新最大值
            }
            return
        }
        maxWeight(i: i + 1, cw: cw) ;//选择不装i个物品
        if cw + weight[i] <= w {
            maxWeight(i: i + 1, cw: weight[i] + cw)
        }
     }
    
    static func testMaxWeight() {
        let problem01Instance = Problem01_BackTrace()
        problem01Instance.maxWeight(i: 0, cw: 0)
        print(problem01Instance.maxW)
    }
}
class Problem0_1 {
    func knapsack(weight: [Int], n: Int, w: Int) -> Int {//weight: 物品重量，n: 物品个数，w: 背包可承载重量
        var states = [[Bool]](repeating: [Bool](repeating: false, count: w+1), count: n)
        states[0][0] = true
        if weight[0] < w {
            states[0][weight[0]] = true
        }
        
        for i in 1..<n {
            for j in 0...w {
                if states[i-1][j] == true {
                    states[i][j] = states[i-1][j]
                }
            }
            for j in 0...w - weight[i] {
                if states[i-1][j] == true {
                    states[i][j+weight[i]] = true
                }
            }
        }
        
        for i in stride(from: w, through: 0, by: -1) {
            if states[n-1][i] == true {
                return i
            }
        }
        return 0
    }
    static func testKnapsack() {
        let problem01 = Problem0_1()
        let weight = [2,2,4,6,3]
        let n = 5
        let w = 9
        
        let result = problem01.knapsack(weight: weight, n: n, w: w)
        print(result)
    }
}

class YangHuiTriangle {
    let matrix = [[5],[7,8],[2,3,4],[4,9,6,1],[2,7,9,4,5]]
    func yanghuiTirangle(_ matrix: [[Int]]) -> Int {
        var states = [[Int]](repeating: [Int](repeating: matrix.count, count: 5), count: matrix.count)
        states[0][0] = matrix[0][0]
        for i in 1..<matrix.count {
            for j in 0..<matrix[i].count {
                if j == 0 {
                    states[i][j] = states[i-1][j] + matrix[i][j]
                } else if j == matrix[i].count - 1 {
                    states[i][j] = states[i-1][j-1] + matrix[i][j]
                } else {
                    let top1 = states[i-1][j-1]
                    let top2 = states[i-1][j]
                    states[i][j] = min(top1, top2) + matrix[i][j]
                }
            }
        }
        
        var minDis = Int.max
        for i in 0..<matrix[matrix.count-1].count {
            let distance = states[matrix.count-1][i]
            if distance < minDis {
                minDis = distance
            }
        }
        return minDis
    }
    static func testTirangle() {
        let triangle = YangHuiTriangle()
        let result = triangle.yanghuiTirangle(triangle.matrix)
        print(result)
    }
}

struct Money {
    func payMoney() {
        //定义输入数据
        let values = [1,3,5] //钱币的种类
        let pm = 9  //支付金额payMoney
        
        //定义自动变量
        let step = pm/values[0] + 1 //定义最大步数
        var states = [[Int]](repeating: [Int](repeating: 0, count: pm+1), count: step) //定义状态图
        
        //初始化第一行
        for i in 0..<values.count {
            states[0][values[i]] = values[i]
        }
        
        //每步选择一种钱币，翻译状态图
        for i in 1..<step {
            for k in 0..<values.count {
                for j in 0...pm-values[k] {  //行
                    if states[i-1][j] > 0 {
                        states[i][j+values[k]] = values[k]
                    }
                }
            }
        }
        
        for i in 0..<step {
            if states[i][pm] > 0 {  //找到了
                print("找到了一种方案： 使用的币的个数：\(i+1)")
                var column  = pm
                for j in stride(from: i, through: 0, by: -1) {
                    let currentMoney = states[j][column]
                    print(currentMoney)  //当前币的大小
                    column -= currentMoney
                }
                break  //退出打印最少币种的方式，不退出打印所有方式。
            }
        }
    }
    static func testPayMoney() {
        let ins = Money()
        ins.payMoney()
    }
}
