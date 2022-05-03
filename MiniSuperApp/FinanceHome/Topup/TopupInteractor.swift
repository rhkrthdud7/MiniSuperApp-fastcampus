//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()

    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdaptivePresentationControllerDelegate {
    weak var router: TopupRouting?
    weak var listener: TopupListener?

    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    private var paymentMethods: [PaymentMethod] {
        dependency.cardOnFileRepository.cardOnfile.value
    }

    private let dependency: TopupInteractorDependency

    init(
        dependency: TopupInteractorDependency
    ) {
        presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        self.dependency = dependency
        super.init()
        presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        if let card = dependency.cardOnFileRepository.cardOnfile.value.first {
            // 금액 입력 화면
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        } else {
            // 카드 추가 화면
            router?.attachAddPaymentMethod()
        }
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }

    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }

    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        listener?.topupDidClose()
    }

    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
    }

    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }

    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: paymentMethods)
    }

    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }

    func cardOnFileDidTapAddCard() {
        // attach add card
    }

    func cardOnFileDidSelect(at index: Int) {
        if let selected = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }
}
