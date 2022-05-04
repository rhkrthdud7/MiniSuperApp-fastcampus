//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import AddPaymentMethod
import CombineUtil
import FinanceEntity
import FinanceRepository
import ModernRIBs
import RIBsUtil
import SuperUI
import Topup

protocol TopupRouting: Routing {
    func cleanupViews()

    func attachAddPaymentMethod(closeButtonType: DismissButtonType)
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
    func popToRoot()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AddPaymentMethodListener, AdaptivePresentationControllerDelegate {
    weak var router: TopupRouting?
    weak var listener: TopupListener?

    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    private var isEnterAmountRoot: Bool = false

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
            isEnterAmountRoot = true
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        } else {
            isEnterAmountRoot = false
            router?.attachAddPaymentMethod(closeButtonType: .close)
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
        if isEnterAmountRoot == false {
            listener?.topupDidClose()
        }
    }

    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        dependency.paymentMethodStream.send(paymentMethod)
        router?.attachEnterAmount()

        if isEnterAmountRoot {
            router?.popToRoot()
        } else {
            isEnterAmountRoot = true
            router?.attachEnterAmount()
        }
    }

    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }

    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: paymentMethods)
    }

    func enterAmountDidFinishTopup() {
        listener?.topupDidFinish()
    }

    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }

    func cardOnFileDidTapAddCard() {
        router?.attachAddPaymentMethod(closeButtonType: .back)
    }

    func cardOnFileDidSelect(at index: Int) {
        if let selected = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }
}
