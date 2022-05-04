//
//  File.swift
//
//
//  Created by Soso on 2022/05/03.
//

import FinanceEntity
import UIKit

struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor

    init(_ paymentMethod: PaymentMethod) {
        name = paymentMethod.name
        digits = "**** \(paymentMethod.digits)"
        color = UIColor(hex: paymentMethod.color) ?? .systemGray2
    }
}
