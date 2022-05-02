//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import UIKit

protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    weak var delegate: AdaptivePresentationControllerDelegate?

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
