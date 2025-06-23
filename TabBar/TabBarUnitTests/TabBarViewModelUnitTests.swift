//
//  TabBarUnitTests.swift
//  TabBarUnitTests
//
//  Created by Trainee on 4/3/25.
//

import XCTest
@testable import TabBar
import SwiftUICore

final class TabBarViewModelUnitTests: XCTestCase {
    
    var viewModel: TabItem!
    var viewControllersProvider: () -> [String: UIViewController] = { [:] }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = TabItem(title: "String", icon: "String", viewController: UIViewController())
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        viewControllersProvider = { [:] }
        try super.tearDownWithError()
    }
    
    func testTabItemSwiftUIViewContent() {
        // Given
        let dummyView = Text("Test")
        let tabItem = TabItem(title: "SwiftUI", icon: "doc", view: dummyView)
        
        // Then
        switch tabItem.content {
        case .swiftUIView(let anyView):
            XCTAssertNotNil(anyView)
        default:
            XCTFail("Expected .swiftUIView case, got \(tabItem.content)")
        }
    }
    func testTabItemUIViewControllerContent() {
        // Given
        let dummyVC = UIViewController()
        let tabItem = TabItem(title: "UIKit", icon: "gear", viewController: dummyVC)
        
        // Then
        switch tabItem.content {
        case .viewController(let vc):
            XCTAssertEqual(vc, dummyVC)
        default:
            XCTFail("Expected .viewController case, got \(tabItem.content)")
        }
    }
    
}
