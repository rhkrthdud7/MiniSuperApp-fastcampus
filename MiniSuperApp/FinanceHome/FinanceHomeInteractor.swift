import ModernRIBs

protocol FinanceHomeRouting: ViewableRouting {
    func attachSuperPayDasboard()
    func attachCardOnFileDashboard()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
}

protocol FinanceHomeListener: AnyObject {
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener {
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?

    override init(presenter: FinanceHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
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
}
