import Foundation

@propertyWrapper
class Inject<T> {
    var wrappedValue: T
    init() {
        if let value = DependencyInitializer.container.resolve(T.self) {
            wrappedValue = value
        } else {
            fatalError("No dependency found for \(T.self)")
        }
    }
}
