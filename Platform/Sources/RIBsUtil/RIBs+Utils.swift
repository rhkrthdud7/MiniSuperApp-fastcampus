//
//  RIBs+Utils.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/03.
//

import ModernRIBs
import UIKit

public enum DismissButtonType {
    case back, close

    public var iconSystem: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
}

public final class NavigationControllerable: ViewControllable {
    public var uiviewController: UIViewController { navigationController }
    public let navigationController: UINavigationController

    public init(root: ViewControllable) {
        let navigation = UINavigationController(rootViewController: root.uiviewController)
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance

        navigationController = navigation
    }
}

public extension ViewControllable {
    func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }

    func dismiss(completion: (() -> Void)?) {
        uiviewController.dismiss(animated: true, completion: completion)
    }

    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = uiviewController as? UINavigationController {
            nav.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }

    func popViewController(animated: Bool) {
        if let nav = uiviewController as? UINavigationController {
            nav.popViewController(animated: animated)
        } else {
            uiviewController.navigationController?.popViewController(animated: animated)
        }
    }

    func popToRoot(animated: Bool) {
        if let nav = uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }

    func setViewControllers(_ viewControllerables: [ViewControllable]) {
        if let nav = uiviewController as? UINavigationController {
            nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        } else {
            uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        }
    }

    var topViewControllable: ViewControllable {
        var top: ViewControllable = self

        while let presented = top.uiviewController.presentedViewController as? ViewControllable {
            top = presented
        }

        return top
    }
}
