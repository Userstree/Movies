//
// Created by Dossymkhan Zhulamanov on 05.06.2022.
//

import Foundation

class Observed<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
