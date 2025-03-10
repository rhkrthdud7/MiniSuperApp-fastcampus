//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by Soso on 2022/05/02.
//

import Combine
import CombineExt
import Foundation

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    public typealias Output = Element
    public typealias Failure = Never

    public var value: Element {
        currentValueRelay.value
    }

    fileprivate let currentValueRelay: CurrentValueRelay<Output>

    fileprivate init(_ initialValue: Element) {
        currentValueRelay = CurrentValueRelay(initialValue)
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Element == S.Input {
        currentValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    public typealias Output = Element
    public typealias Failure = Never

    override public init(_ initialValue: Element) {
        super.init(initialValue)
    }

    public func send(_ value: Element) {
        currentValueRelay.accept(value)
    }
}
