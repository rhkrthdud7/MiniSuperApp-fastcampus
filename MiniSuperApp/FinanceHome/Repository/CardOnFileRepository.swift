//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import Foundation

protocol CardOnfileRepository {
    var cardOnfile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnfileRepository {
    var cardOnfile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMehodSubject }

    private let paymentMehodSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "신한은행", digits: "0987", color: "#3478f6ff", isPrimary: false),
        PaymentMethod(id: "2", name: "현대은행", digits: "8121", color: "#78c5f5ff", isPrimary: false),
        PaymentMethod(id: "3", name: "국민은행", digits: "2812", color: "#65c466ff", isPrimary: false),
        PaymentMethod(id: "4", name: "카카오뱅크", digits: "8751", color: "#ffcc00ff", isPrimary: false),
    ])
}
