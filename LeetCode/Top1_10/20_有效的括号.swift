//
//  20_有效的括号.swift
//  DataStruct
//
//  Created by lijian on 2019/7/30.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class solution_20_有效的括号 {
    func isValid(_ s: String) -> Bool {
        let map: [Character: Character] = [
                   ")":"(",
                   "}":"{",
                   "]":"["
        ]
        let stack = Stack<Character>()
        let aa = [Character](s)
        for  ch in aa {
            if !map.keys.contains(ch) {  //如果不是key，左边括号
                stack.push(ch)
            } else {
                //取出栈顶元素
                if stack.isEmpty() {
                    return false
                }
                let top = stack.top()
                if let value = map[ch] {
                    if value != top {
                        return false
                    } else {  //弹出栈顶元素
                        stack.pop()
                    }
                } else {
                    return false
                }
            }
        }
        if stack.isEmpty() {
            return true
        }
        return false
    }
}

extension solution_20_有效的括号 {
    static func test() {
        let instance = solution_20_有效的括号()
        
        assert(instance.isValid("()"))
        
        
        assert(instance.isValid("()[]{}"))
        
        assert(instance.isValid("(]") == false)
        
        assert(instance.isValid("([)]") == false)
        
        assert(instance.isValid("{[]}"))
        
        print("所有测试通过")
    }
}
