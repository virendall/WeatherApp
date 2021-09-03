import Foundation

class DisposeBag {
    private var disposables: [Disposable] = []
    func append(_ disposable: Disposable) { disposables.append(disposable) }
}
