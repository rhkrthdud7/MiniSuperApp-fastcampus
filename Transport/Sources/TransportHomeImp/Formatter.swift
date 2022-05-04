//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/04.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
