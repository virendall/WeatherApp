import Foundation

class Disposable {
    let dispose: () -> Void
    init(_ dispose: @escaping () -> Void) { self.dispose = dispose }
    deinit { dispose() }
}

extension Disposable {
    func disposed(by bag: DisposeBag?) {
        bag?.append(self)
    }
}
