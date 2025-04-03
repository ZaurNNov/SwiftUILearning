//
//  NewMockDataService_Tests.swift
//  SwiftUILearning_Tests
//
//  Created by Zaur  on 04.04.2025.
//

import XCTest
import Combine
@testable import SwiftUILearning

final class NewMockDataService_Tests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        cancellables.removeAll()
    }
    
    func test_NewMockDataService_init_doesCorrectly() {
        // Given
        let items1: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService1 = NewMockDataService(items: items1)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        
        // Then
        XCTAssertFalse(dataService1.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = expectation(description: "Downloaded items")
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = expectation(description: "Downloaded items")
        
        dataService.downloadItemsWithCombine()
            .sink { complition in
                switch complition {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
                
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = NewMockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation = expectation(description: "Downloaded items")
        //let expectation2 = expectation(description: "Throw error")
        let expectation2 = XCTestExpectation(description: "Throw error")

        dataService.downloadItemsWithCombine()
            .sink { complition in
                switch complition {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
                
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        // Then
        // some as wait(for: [expectation, expectation2], timeout: 5)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
