import Combine
import CombineUtil
import Foundation
import ModernRIBs
import TransportHome

protocol TransportHomeRouting: ViewableRouting {
    func attachTopup()
    func detachTopup()
}

protocol TransportHomePresentable: Presentable {
    var listener: TransportHomePresentableListener? { get set }
    func setSuperPayBalance(_ balance: String)
}

protocol TransportHomeInteractorDependency {
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {
    weak var router: TransportHomeRouting?
    weak var listener: TransportHomeListener?

    private let dependency: TransportHomeInteractorDependency

    private var cancellables: Set<AnyCancellable>

    private let ridePrice: Double = 18000

    init(
        presenter: TransportHomePresentable,
        dependency: TransportHomeInteractorDependency
    ) {
        self.dependency = dependency
        cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        dependency.superPayBalance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] balance in
                if let balanceText = Formatter.balanceFormatter.string(from: NSNumber(value: balance)) {
                    self?.presenter.setSuperPayBalance(balanceText)
                }
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
    }

    func didTapBack() {
        listener?.transportHomeDidTapClose()
    }

    func didTapRideConfirmButton() {
        if dependency.superPayBalance.value < ridePrice {
            router?.attachTopup()
        } else {
        }
    }

    func topupDidClose() {
        router?.detachTopup()
    }

    func topupDidFinish() {
        router?.detachTopup()
    }
}
