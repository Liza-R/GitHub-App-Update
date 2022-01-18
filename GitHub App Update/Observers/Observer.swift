import Foundation

class Observer<Value> {
    var value: Value {
        didSet {
            observers?(value)
        }
    }
    
    private var observers: ((Value) -> Void)?

    init(value: Value) {
        self.value = value
    }
    
    func subscribe(_ observer: @escaping (Value) -> Void) {
        observer(value)
        observers = observer
    }
}
