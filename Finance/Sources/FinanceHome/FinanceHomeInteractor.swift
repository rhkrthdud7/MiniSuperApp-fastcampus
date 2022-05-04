import FinanceEntity
import ModernRIBs
import SuperUI

protocol FinanceHomeRouting: ViewableRouting {
    func attachSuperPayDasboard()
    func attachCardOnFileDashboard()
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachTopup()
    func detachTopup()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
}

public protocol FinanceHomeListener: AnyObject {
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener, AdaptivePresentationControllerDelegate {
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?

    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    override init(presenter: FinanceHomePresentable) {
        presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init(presenter: presenter)
        presenter.listener = self
        presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        router?.attachSuperPayDasboard()
        router?.attachCardOnFileDashboard()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func presentationControllerDidDismiss() {
        router?.detachAddPaymentMethod()
    }

    func cardOnFileDashboardDidTapAddPaymentMethod() {
        router?.attachAddPaymentMethod()
    }

    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
    }

    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        router?.detachAddPaymentMethod()
    }

    func superPayDashboardDidTapTopup() {
        router?.attachTopup()
    }

    func topupDidClose() {
        router?.detachTopup()
    }

    func topupDidFinish() {
        router?.detachTopup()
    }
}
