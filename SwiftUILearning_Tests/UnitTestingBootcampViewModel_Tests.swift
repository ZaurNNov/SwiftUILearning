//
//  UnitTestingBootcampViewModel_Tests.swift
//  SwiftUILearning_Tests
//
//  Created by Zaur  on 03.04.2025.
//

import XCTest
import Combine
@testable import SwiftUILearning

// Testing structure:
// Given
// When
// Then

// Naming struucture: test_[srtuct or class]_[variable or func]_[expected result]

final class UnitTestingBootcampViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingBootcampViewModel?
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())

    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testUnitTestingViewModel_isPremium_shouldBeTrue() {
        //Given
        let userIsPremium: Bool = true
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        assert(vm.isPremium, "It will be true")
    }
    
    func testUnitTestingViewModel_isPremium_shouldBeFalse() {
        //Given
        let userIsPremium: Bool = false
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium, "It will be false")
        //assert(!vm.isPremium, "It will be false")
    }
    
    func testUnitTestingViewModel_isPremium_shouldBeIjectedValue() {
        //Given
        let userIsPremium: Bool = Bool.random()
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func testUnitTestingViewModel_isPremium_shouldBeIjectedValue_stress() {
        //Given
        for _ in 0..<10 {
            //Given
            let userIsPremium: Bool = Bool.random()
            
            //When
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
            
            //Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func testUnitTestingViewModel_dataArray_shouldBeEmpty() {
        //Given
        
        //When
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }

    func testUnitTestingViewModel_dataArray_shouldAddItems() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        //let loopCount = 10
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func testUnitTestingViewModel_dataArray_shouldNotAddBlancString() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
                
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func testUnitTestingViewModel_selectedItem_shouldStartAsNil() {
        //Given
        
        //When
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func testUnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidValue() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func testUnitTestingViewModel_selectedItem_shouldBeSelected() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let new = UUID().uuidString
        vm.addItem(item: new)
        vm.selectItem(item: new)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, new)
    }
    
    func testUnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let loopCount: Int = 100
        var itemsArrey: [String] = []
        for _ in 0..<loopCount {
            let new = UUID().uuidString
            vm.addItem(item: new)
            itemsArrey.append(new)
        }
        let randomItem = itemsArrey.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func testUnitTestingViewModel_saveItem_shouldThrowError_noData() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: ""))
        XCTAssertThrowsError(try vm.saveItem(item: ""), "Should throw error when saving item with no data") { errorPointer in
            let returnError = errorPointer as? UnitTestingBootcampViewModel.LocalErrors
            XCTAssertEqual(returnError, UnitTestingBootcampViewModel.LocalErrors.noData)
        }
    }
    
    func testUnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let loopCount: Int = 100
        var itemsArrey: [String] = []
        for _ in 0..<loopCount {
            let new = UUID().uuidString
            vm.addItem(item: new)
            itemsArrey.append(new)
        }
        let randomItem = itemsArrey.randomElement() ?? ""
        
        //Then
        XCTAssertNotEqual(randomItem, "")
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }

    func testUnitTestingViewModel_downloadWithEscaping_shouldReturnItems() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let expectation = XCTestExpectation(description: "Download completed")
        
        vm.$dataArray
            .dropFirst()
            .sink { downloadedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func testUnitTestingViewModel_downloadWithCombine_shouldReturnItems2() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let expectation = XCTestExpectation(description: "Download completed")
        
        vm.$dataArray
            .dropFirst()
            .sink { downloadedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func testUnitTestingViewModel_downloadWithCombine_shouldReturnItems3() {
        //Given
        let items: [String] = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random(), dataService: dataService)
        
        //When
        let expectation = XCTestExpectation(description: "Download completed")
        
        vm.$dataArray
            .dropFirst()
            .sink { downloadedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
}
