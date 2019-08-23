//
//  96_不同的二叉搜索树.swift
//  DataStruct
//
//  Created by lijian on 2019/8/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


class Solution_不同的二叉搜索树 {
    func numTrees(_ n: Int) -> Int {
        guard n>1 else {
            return 1
        }
        var state:[Int] = [Int](repeating: 0, count: n+1)
        state[0] = 1
        state[1] = 1

        for i in 2...n {
            for j in 1...i {
                state[i] += (state[j-1]*state[i-j]);
            }
        }
        return state[n]
    }
}



