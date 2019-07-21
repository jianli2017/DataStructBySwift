//
//  TestGraphSreach.swift
//  DataStruct
//
//  Created by lijian on 2019/7/20.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class TestSearch {
    static func test() {
        let path = GraphFileName
        let file = ReadFile(fileName: path)
        if file != nil {
            let graph = Graph(inStream: file!)
            if graph != nil {
                
                let search = DepthFirstSearch(G: graph!, s: 0)
                for i in 0..<graph!.V() {
                    if search.marked(i) {
                        print(i, separator: "", terminator: ",")
                    }
                }
                print(" ")
                if search.count() != graph!.V() {
                    print("not connet!")
                } else {
                    print("connect")
                }
//                let result = graph!.toString()
//                print(result)
                
            }
        }
    }

}
