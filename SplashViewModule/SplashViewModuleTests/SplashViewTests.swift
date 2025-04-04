import XCTest
@testable import SplashViewModule

final class AWSConfigManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDownWithError() throws {

    }

    func test_LoadConfigFileDoesNotExist() {
        let configManager = AWSConfigManager.shared
        XCTAssertNil(configManager.loadConfig())
    }


    func test_CreateAWSConfigWithInvalidConfiguration() throws {
        let configManager = AWSConfigManager()

        do {
            _ = try configManager.createAWSConfigurationFile()
            XCTFail("Expected Error Configuration Not Found")
        } catch {
            XCTAssertNotNil(error, "Expected Error Configuration Not Found")
        }
    }
}
