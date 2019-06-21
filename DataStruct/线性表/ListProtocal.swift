//
//  ListProtocal.swift
//  DataStruct
//
//  Created by lijian on 2019/6/19.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

protocol ListProtocal {
    //存储元素的类型
    associatedtype ElementType
    
    //元素的数量
    func size() -> Int
    
    //是否为空
    func isEmpty()-> Bool
    
    //是否包含某个元素
    func contains(_ element: ElementType) -> Bool
    
    //返回index位置对于的元素
    func get(index: Int)->ElementType?
    
    //设置index位置的元素
    func set(index: Int, element: ElementType)->ElementType?
    
    //往index位置添加元素
    func add(index: Int, element: ElementType) 
    
    //删除index位置对应的元素
    func remove(index: Int)->ElementType?
    
    //查看元素的位置
    func indexOf(element: ElementType)->Int?
    
    //清楚所有元素
    func clear()
    
}
