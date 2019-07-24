//
//  Stack.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

//模拟实现栈
import Foundation

class Stack<E> {
    private var _array = [E]()
    
    func push(_ element: E)  {
        self._array.insert(element, at: 0)
    }
    
    func pop() -> E? {
        if self.isEmpty() {
            return nil
        }
        let ret = self._array.removeFirst()
        return ret
    }
    
    func isEmpty() -> Bool {
        return self._array.isEmpty
    }
    
    func iterater() -> [E] {
        return self._array
    }
}
