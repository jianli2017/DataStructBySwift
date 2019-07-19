//
//  common.swift
//  DataStruct
//
//  Created by lijian on 2019/7/19.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


extension Character
{
    func toInt() -> Int
    {
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars
        {
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}

