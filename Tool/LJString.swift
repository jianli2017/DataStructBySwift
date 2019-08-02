//
//  LJString.swift
//  DataStruct
//
//  Created by lijian on 2019/7/29.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

extension String {
    func ljIndex(_ distance: Int) ->Index {
        return self.index(self.startIndex, offsetBy: distance)
    }
}
