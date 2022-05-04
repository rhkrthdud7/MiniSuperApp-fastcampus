//
//  AddPaymentMethodInfo.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import Foundation

public struct AddPaymentMethodInfo {
    public let number: String
    public let cvc: String
    public let expiry: String

    public init(
        number: String,
        cvc: String,
        expiry: String
    ) {
        self.number = number
        self.cvc = cvc
        self.expiry = expiry
    }
}
