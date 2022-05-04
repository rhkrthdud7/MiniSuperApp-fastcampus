//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import Combine
import CombineUtil
import FinanceEntity
import Foundation

public protocol CardOnFileRepository {
    var cardOnfile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    public var cardOnfile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodSubject }

    private let paymentMethodSubject = CurrentValuePublisher<[PaymentMethod]>([
//        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//        PaymentMethod(id: "1", name: "신한은행", digits: "0987", color: "#3478f6ff", isPrimary: false),
//        PaymentMethod(id: "2", name: "현대은행", digits: "8121", color: "#78c5f5ff", isPrimary: false),
//        PaymentMethod(id: "3", name: "국민은행", digits: "2812", color: "#65c466ff", isPrimary: false),
//        PaymentMethod(id: "4", name: "카카오뱅크", digits: "8751", color: "#ffcc00ff", isPrimary: false),
    ])

    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let paymentMethod = PaymentMethod(id: "00", name: "New 카드", digits: "\(info.number.suffix(4))", color: "", isPrimary: false)

        var new = paymentMethodSubject.value
        new.append(paymentMethod)
        paymentMethodSubject.send(new)

        return Just(paymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public init() {
    }
}
