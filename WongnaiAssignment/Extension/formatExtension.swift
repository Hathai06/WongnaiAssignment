//
//  formatExtension.swift
//  WongnaiAssignment
//
//  Created by Nuan on 23/11/2562 BE.
//  Copyright © 2562 Hathairat. All rights reserved.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

