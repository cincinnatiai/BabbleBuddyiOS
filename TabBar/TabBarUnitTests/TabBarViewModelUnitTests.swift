//
//  TabBarUnitTests.swift
//  TabBarUnitTests
//
//  Created by Trainee on 4/3/25.
//

import XCTest
@testable import TabBar

final class TabBarViewModelUnitTests: XCTestCase {
    
    var viewModel: TabBarViewModel!
    var viewControllersProvider: () -> [String: UIViewController] = { [:] }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = TabBarViewModel(viewControllersProvider: viewControllersProvider)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewControllersProvider = { [:] }
        try super.tearDownWithError()
    }
    
    func testInitialStateIsLoading() {
        XCTAssertEqual(viewModel.screensState, .loading)
    }
    
    func testConfigureTabsSucceedsWithExpectedViewController() async {
        // Given
        let settingsVC = await UIViewController()
        let homeVC = await UIViewController()
            
            viewControllersProvider = {
                return [
                    "settings": settingsVC,
                    "home": homeVC
                ]
            }
            
            viewModel = TabBarViewModel(viewControllersProvider: viewControllersProvider)
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { expectation.fulfill() }
        
        // When
        viewModel.initialize()
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)

            if case .success(let viewControllers) = viewModel.screensState {
                XCTAssertEqual(viewControllers.count, 2)
                XCTAssertTrue(viewControllers.first is UINavigationController)
            } else {
                XCTFail("Unexpercted state: \(viewModel.screensState)")
            }
        }
    
    func testConfigureTabsWithEmptyDictionarySucceedsWithNoViewControllers() async {
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { expectation.fulfill() }
        
        // When
        viewModel.initialize()
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
            if case .success(let viewControllers) = viewModel.screensState {
                XCTAssertTrue(viewControllers.isEmpty)
            } else {
                XCTFail("Unexpercted state: \(viewModel.screensState)")
            }
        }
    
    func testConfigureTabsSucceedsWithUnexpectedViewController() async {
        // Given
        let unknownVC = await UIViewController()
        viewControllersProvider = {
            return [
                "unknown": unknownVC
            ]
        }
            
        viewModel = TabBarViewModel(viewControllersProvider: viewControllersProvider)

        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { expectation.fulfill() }
        
        // When
        viewModel.initialize()
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        
        await MainActor.run {
            if case .success(let viewControllers) = viewModel.screensState {
                XCTAssertEqual(viewControllers.count, 1)
                XCTAssertEqual(viewControllers.first?.tabBarItem.title, "Default")
            } else {
                XCTFail("Unexpected state: \(viewModel.screensState)")
            }
        }
    }
}
