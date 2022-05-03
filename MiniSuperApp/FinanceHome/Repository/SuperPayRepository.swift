//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/03.
//

import Combine
import Foundation

protocol SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

final class SuperPayRepositoryImp: SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSuubject }
    private let balanceSuubject = CurrentValuePublisher<Double>(0)

    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            self?.bgQueue.async {
                Thread.sleep(forTimeInterval: 2)
                promise(.success(()))
                let newBalance = (self?.balanceSuubject.value).map { $0 + amount }
                newBalance.map { self?.balanceSuubject.send($0) }
            }
        }.eraseToAnyPublisher()
    }

    private let bgQueue = DispatchQueue(label: "topup.repository.queue")
}
