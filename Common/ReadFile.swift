//
//  ReadFile.swift
//  DataStruct
//
//  Created by lijian on 2019/7/19.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

class ReadFile {
    var fileName : String
    var lines: [String]
    init?(fileName: String) {
        self.fileName = fileName
        let handle = FileHandle(forReadingAtPath: fileName)
        let fileContent = handle?.readDataToEndOfFile()
        if fileContent != nil {
            let content = String(data: fileContent!, encoding: String.Encoding.utf8)
            if content != nil {
                lines = content!.components(separatedBy: CharacterSet.newlines)
            } else {
                return nil
            }
        } else {
            return nil
        }
        if lines.count == 0 {
            return nil
        }
        
        lines=lines.filter {
            !($0.isEmpty)
        }
    }
    
    func readLine() -> String? {
        guard lines.count != 0 else {
            return nil
        }
        let ret = lines.removeFirst()
        return ret
    }
    
    func readInt() -> Int? {
        let line = readLine()
        guard line != nil else {
            return nil
        }
        var words = line!.components(separatedBy: CharacterSet.whitespaces)
        let stringInt = words.removeFirst()
        if words.count > 0 {
            let modified = words.joined(separator: " ")
            lines.insert(modified, at: 0)
        }
        return Int(stringInt)
    }
    
    func readDouble() -> Double? {
        let line = readLine()
        guard line != nil else {
            return nil
        }
        var words = line!.components(separatedBy: CharacterSet.whitespaces)
        let stringDouble = words.removeFirst()
        if words.count > 0 {
            let modified = words.joined(separator: " ")
            lines.insert(modified, at: 0)
        }
        return Double(stringDouble)
    }
}
