import Foundation

@propertyWrapper
class InjectWithArg<T, Arg> {
    private let argument: Arg
    var wrappedValue: T {
        guard let value = DependencyInitializer.container.resolve(T.self, argument: argument) else {
            fatalError("No dependency found for \(T.self) with argument: \(argument)")
        }
        return value
    }
    
    init (_ argument: Arg) {
        self.argument = argument
    }
}
