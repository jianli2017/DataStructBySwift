//
//  Queue.swift
//  DataStruct
//
//  Created by lijian on 2019/7/23.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


class Queue<E> {
    private var _array = [E]()
    
    func enqueue(_ element: E)  {
        self._array.append(element)
    }
    
    func dequeue() -> E? {
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
