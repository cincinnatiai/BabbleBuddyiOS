import XCTest
@testable import SplashViewModule

final class SplashViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDownWithError() throws {

    }

    func test_showErrorScreen() {
        // Given
        let mockVM = MockSplashViewModel(mainScreen: { UIViewController() })
        mockVM.shouldFail = true
        let splashVC = SplashViewController(splashViewModel: mockVM)

        // When
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = splashVC
        window.makeKeyAndVisible()
        splashVC.loadViewIfNeeded()

        // Then
        let expectation = XCTestExpectation(description: "Wait for error screen")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(splashVC.presentedViewController is UIAlertController)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func test_navigateMainScreen_called() {
        // Given
        let mainVC = UIViewController()
        mainVC.view.accessibilityIdentifier = "MainScreen"

        let mockVM = MockSplashViewModel(mainScreen: { mainVC })
        mockVM.shouldFail = false

        let splashVC = TestableSplashViewController(splashViewModel: mockVM)

        // When
        splashVC.loadViewIfNeeded()

        // Then
        let expectation = XCTestExpectation(description: "Wait for navigation method")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(splashVC.didNavigateToMainScreen)
            XCTAssertEqual(splashVC.receivedMainVC?.view.accessibilityIdentifier, "MainScreen")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
