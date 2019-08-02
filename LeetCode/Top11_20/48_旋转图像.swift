//
//  48_旋转图像.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

/*
 给定一个 n × n 的二维矩阵表示一个图像。
 
 将图像顺时针旋转 90 度。
 
 说明：
 
 你必须在原地旋转图像，这意味着你需要直接修改输入的二维矩阵。请不要使用另一个矩阵来旋转图像。
 
 示例 1:
 
 给定 matrix =
 [
 [1,2,3],
 [4,5,6],
 [7,8,9]
 ],
 
 原地旋转输入矩阵，使其变为:
 [
 [7,4,1],
 [8,5,2],
 [9,6,3]
 ]
 示例 2:
 
 给定 matrix =
 [
 [ 5, 1, 9,11],
 [ 2, 4, 8,10],
 [13, 3, 6, 7],
 [15,14,12,16]
 ],
 
 原地旋转输入矩阵，使其变为:
 [
 [15,13, 2, 5],
 [14, 3, 4, 1],
 [12, 6, 8, 9],
 [16, 7,10,11]
 ]
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/rotate-image
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


class Solution_48_旋转图像 {
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count;
        // 转置矩阵
        for i in 0..<n {
            for j in i..<n {
                let tmp = matrix[j][i];
                matrix[j][i] = matrix[i][j];
                matrix[i][j] = tmp;
            }
        }
        // reverse each row
        for i in 0..<n {
            for j in 0..<n/2 {
                let tmp = matrix[i][j];
                matrix[i][j] = matrix[i][n - j - 1];
                matrix[i][n - j - 1] = tmp;
            }
        }
    }
}

extension Solution_48_旋转图像 {
    static func test() {
        let instance = Solution_48_旋转图像()
        var matrix =
        [
            [1,2,3],
            [4,5,6],
            [7,8,9]
        ]
        instance.rotate(&matrix)
        print(matrix)
    }
}

