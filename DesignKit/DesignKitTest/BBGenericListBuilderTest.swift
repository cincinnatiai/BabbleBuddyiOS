import XCTest
import UIKit
@testable import DesignKit  // Replace with your actual module name

class BBGenericListBuilderTests: XCTestCase {
    
    class TestCell: UITableViewCell {
        var configuredText: String?
    }
    
    func testListDisplaysCorrectNumberOfItems() {
        let listBuilder: BBGenericListBuilder<String, TestCell> = BBGenericListBuilder()
        listBuilder.items = ["One", "Two", "Three"]
        
        // Force layout
        listBuilder.layoutIfNeeded()
        
        let tableView = listBuilder.subviews.first(where: { $0 is UITableView })
        
        let rows = listBuilder.tableView(listBuilder.testTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 3, "TableView should have 3 rows")
    }
    
    func testCellConfiguration() {
        let expectation = self.expectation(description: "Cell configuration called")
        let listBuilder = BBGenericListBuilder<String, TestCell>()
        listBuilder.items = ["Hello"]
        
        listBuilder.configureCell = { cell, item in
            cell.configuredText = item
            XCTAssertEqual(item, "Hello")
            expectation.fulfill()
        }
        
        _ = listBuilder.tableView(listBuilder.testTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1)
    }
    
    func testDidSelectItemCallback() {
        let listBuilder: BBGenericListBuilder<String, TestCell> = BBGenericListBuilder()
        listBuilder.items = ["A", "B", "C"]

        var selected: String?
        listBuilder.didSelectItem = { item in
            selected = item
        }

        let indexPath = IndexPath(row: 1, section: 0)
        listBuilder.tableView(listBuilder.testTableView, didSelectRowAt: indexPath)

        XCTAssertEqual(selected, "B")
    }
}
