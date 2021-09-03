import Foundation

class Box<T> {
    typealias Listener = (T) -> Void

    private  var listeners: [UUID:  Listener] = [:]
    
    var value: T {
        didSet {
            notifyListeners()
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func notifyListeners(){
        listeners.values.forEach { $0(value) }
    }
    
    func bind(listener: @escaping Listener) -> Disposable {
        let identifier = UUID()
        self.listeners[identifier] = listener
        return Disposable { self.listeners.removeValue(forKey: identifier) }
    }

    func bindAndFire(listener: @escaping Listener) -> Disposable {
        let bag = self.bind(listener: listener)
        listener(value)
        return bag
    }
}
