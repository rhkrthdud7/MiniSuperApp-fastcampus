//
//  EnterAmountInteractor.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/03.
//

import Combine
import ModernRIBs

protocol EnterAmountRouting: ViewableRouting {
}

protocol EnterAmountPresentable: Presentable {
    var listener: EnterAmountPresentableListener? { get set }

    func updateSelectedPaymentMethod(with viewModel: SelectedPaymentMethodViewModel)
}

protocol EnterAmountListener: AnyObject {
    func enterAmountDidTapClose()
    func enterAmountDidTapPaymentMethod()
}

protocol EnterAmountInteractorDependency {
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { get }
}

final class EnterAmountInteractor: PresentableInteractor<EnterAmountPresentable>, EnterAmountInteractable, EnterAmountPresentableListener {
    weak var router: EnterAmountRouting?
    weak var listener: EnterAmountListener?

    private let dependency: EnterAmountInteractorDependency

    private var cancellables: Set<AnyCancellable>

    init(
        presenter: EnterAmountPresentable,
        dependency: EnterAmountInteractorDependency
    ) {
        self.dependency = dependency
        cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        dependency.selectedPaymentMethod.sink { [weak self] paymentMethod in
            self?.presenter.updateSelectedPaymentMethod(with: SelectedPaymentMethodViewModel(paymentMethod))
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
    }

    func didTapClose() {
        listener?.enterAmountDidTapClose()
    }

    func didTapPaymentMethod() {
        listener?.enterAmountDidTapPaymentMethod()
    }

    func didTapTopup(with amount: Double) {
    }
}
