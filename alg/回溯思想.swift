//
//  回溯思想.swift
//  DataStruct
//
//  Created by lijian on 2019/7/17.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class Queen8 {
    var count = 0
    
    var result = Array(repeating: 0, count: 8)
    func cal8Queens(row:Int) {
        if row == 8 {
            printQueens(result: result)
            return
        }
        
        for column in 0..<8 {  //每一行都有8种方法
            if isOK(row: row, column: column) {
                result[row] = column
                cal8Queens(row: row + 1)
            }
        }
    }
    
    func isOK(row: Int, column: Int) -> Bool {
        var leftUp = column - 1
        var rightUp = column + 1
        for i in stride(from: row-1, through: 0, by: -1) {
            if result[i] == column {
                return false
            }
            
            if leftUp >= 0 && result[i] == leftUp {
                return false
            }
            
            if rightUp < 8 && result[i] == rightUp {
                return false
            }
            
            leftUp -= 1
            rightUp += 1
        }
        return true
    }
    
    func printQueens(result: [Int]) {
        for i in 0..<8 {
            for j in 0..<8 {
                if result[i] == j {
                    print("Q ", terminator: "")
                } else {
                    print("* ", terminator: "")
                }
            }
            print(" ")
        }
        print("一种方案完成---------")
        count += 1
    }
    
    static func testQueen8() {
        let queen = Queen8()
            
        queen.cal8Queens(row: 0)
        print(queen.count)  //92种方案
    }
}
/*
public int maxW = Integer.MIN_VALUE; // 存储背包中物品总重量的最大值
// cw 表示当前已经装进去的物品的重量和；i 表示考察到哪个物品了；
// w 背包重量；items 表示每个物品的重量；n 表示物品个数
// 假设背包可承受重量 100，物品个数 10，物品重量存储在数组 a 中，那可以这样调用函数：
// f(0, 0, a, 10, 100)
public void f(int i, int cw, int[] items, int n, int w) {
    if (cw == w || i == n) { // cw==w 表示装满了 ;i==n 表示已经考察完所有的物品
        if (cw > maxW) maxW = cw;
        return;
    }
    f(i+1, cw, items, n, w);
    if (cw + items[i] <= w) {// 已经超过可以背包承受的重量的时候，就不要再装了
        f(i+1,cw + items[i], items, n, w);
    }
}*/
