//
//  File.swift
//
//
//  Created by Soso on 2022/05/04.
//

import ModernRIBs

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public protocol TopupListener: AnyObject {
    func topupDidClose()
    func topupDidFinish()
}
