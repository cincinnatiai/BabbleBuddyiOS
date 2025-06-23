import XCTest
import SwiftUI
import ViewInspector
@testable import DesignKit

final class EmptyStateViewTests: XCTestCase {
    
    func testTitleIsDisplayed() throws {
        let view = EmptyStateView(title: "Test Title")
        let vStack = try view.inspect().vStack()
        let textView = try vStack.find(ViewType.Text.self) {
            try $0.string() == "Test Title"
        }
        
        XCTAssertEqual(try textView.string(), "Test Title")
    }
    
    func testTitleAndMessageAreDisplayed() throws {
        let view = EmptyStateView(title: "Test", message: "Additional message")
        let vstack = try view.inspect().vStack()
        let titleText = try vstack.find(ViewType.Text.self) {
            try $0.string() == "Test"
        }
        XCTAssertEqual(try titleText.string(), "Test")
        
        let messageText = try vstack.find(ViewType.Text.self) {
            try $0.string() == "Additional message"
        }
        XCTAssertEqual(try messageText.string(), "Additional message")
    }
    
    func testMessageIsDisplayedIfPresent() throws {
        let view = EmptyStateView(title: "Test", message: "Additional message")
        let vstack = try view.inspect().vStack()
        let messageText = try vstack.text(2)
        XCTAssertEqual(try messageText.string(), "Additional message")
    }
    
    func testButtonAppearsWithActionTitle() throws {
        let view = EmptyStateView(
            title: "Test",
            actionTitle: "Retry",
            action: {}
        )
        
        let button = try view.inspect().vStack().find(ViewType.Button.self)
        let buttonLabel = try button.labelView().text().string()
        
        XCTAssertEqual(buttonLabel, "Retry")
    }
    
    func testImageIsPresent() throws {
        let view = EmptyStateView(title: "Test", image: Image(systemName: "tray"))
        let image = try view.inspect().vStack().image(0)
        XCTAssertNoThrow(image)
    }
    
    func testActionIsTriggeredOnButtonTap() throws {
        var wasTapped = false
        let view = EmptyStateView(
            title: "Test",
            actionTitle: "Do Something",
            action: { wasTapped = true }
        )
        
        let button = try view.inspect().vStack().find(ViewType.Button.self)
        try button.tap()
        
        XCTAssertTrue(wasTapped)
    }
}
