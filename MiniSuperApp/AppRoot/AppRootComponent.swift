//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/04.
//

import AddPaymentMethod
import AddPaymentMethodImp
import AppHome
import FinanceHome
import FinanceRepository
import Foundation
import ModernRIBs
import ProfileHome
import Topup
import TopupImp
import TransportHome
import TransportHomeImp

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency {
    var cardOnFileRepository: CardOnFileRepository
    var superPayRepository: SuperPayRepository

    lazy var transportHomeBuildable: TransportHomeBuildable = {
        TransportHomeBuilder(dependency: self)
    }()

    lazy var topupBuildable: TopupBuildable = {
        TopupBuilder(dependency: self)
    }()
    
    lazy var addPaymentMethodBuildable: AddPaymentMethodBuildable = {
        AddPaymentMethodBuilder(dependency: self)
    }()

    var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }

    private let rootViewController: ViewControllable

    init(
        dependency: AppRootDependency,
        cardOnFileRepository: CardOnFileRepository,
        superPayRepository: SuperPayRepository,
        rootViewController: ViewControllable
    ) {
        self.cardOnFileRepository = cardOnFileRepository
        self.superPayRepository = superPayRepository
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
