//
//  Array+Utils.swift
//
//
//  Created by Soso on 2022/05/03.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
