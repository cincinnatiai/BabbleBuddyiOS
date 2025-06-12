//
//  BabyRegistrationModuleTests.swift
//  BabyRegistrationModuleTests
//
//  Created by Trainee on 5/9/25.
//

import XCTest
@testable import BabyRegistrationModule

final class BabyRegistrationViewModelTests: XCTestCase {
    
    var viewModel: BabyRegistrationViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = BabyRegistrationViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testValidFormWithRequiredFieldsOnly() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertTrue(isValid)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testInvalidWhenFirstNameIsEmpty() {
        // Given
        viewModel.firstName = ""
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.emptyFirstName.localizedDesription)
    }
    
    func testInvalidWhenLastNameIsEmpty() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = ""
        viewModel.selectedGender = "Male"
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.emptyLastName.localizedDesription)
    }
    
    func testInvalidWhenGenderIsNotSelected() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = ""
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.emptyGender.localizedDesription)
    }
    
    func testInvalidBirthWeightWhenNonNumeric() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        viewModel.birthWeight = "two"
        viewModel.selectedWeightUnit = "kg"
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.invalidWeightValue.localizedDesription)
    }
    
    func testInvalidBirthWeightWhenNonUnit() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        viewModel.birthWeight = "2"
        viewModel.selectedWeightUnit = ""
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.emptyWeigthUnit .localizedDesription)
    }

    
    func testValidBirthWeightWhenFieldIsEmpty() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        viewModel.birthWeight = ""
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertTrue(isValid)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testInvalidBirthHeightWhenNonNumeric() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        viewModel.birthWeight = "2"
        viewModel.selectedWeightUnit = "kg"
        viewModel.birthHeight = "two"
        viewModel.selectedHeightUnit = "cm"
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.invalidHeightValue.localizedDesription)
    }
    
    func testInvalidBirthHeightWhenNonUnit() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        viewModel.birthWeight = "2"
        viewModel.selectedWeightUnit = "kg"
        viewModel.birthHeight = "2"
        viewModel.selectedHeightUnit = ""
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.errorMessage, BabyRegistrationResources.ValidationErrors.emptyHeightUnit.localizedDesription)
    }

    
    func testValidBirthHeightWhenFieldIsEmpty() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        viewModel.birthWeight = "2"
        viewModel.selectedWeightUnit = "kg"
        viewModel.birthHeight = ""
        
        // When
        let isValid = viewModel.validateForm()
        
        // Then
        XCTAssertTrue(isValid)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    
    func testSubmitCallsCallback() {
        // Given
        viewModel.firstName = "First"
        viewModel.lastName = "Last"
        viewModel.selectedGender = "Male"
        
        let expectation = XCTestExpectation(description: "onSubmit callback should be called")
        
        // Then
        viewModel.onSubmit = { data in
            XCTAssertEqual(data.firstName, "First")
            XCTAssertEqual(data.lastName, "Last")
            expectation.fulfill()
        }
        // When
        viewModel.onSubmitTapped()
        wait(for: [expectation], timeout: 1.0)
    }
}
