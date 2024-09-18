//
//  BeautyBlissAppTests.swift
//  BeautyBlissAppTests
//
//  Created by Sevde Aydın on 6.07.2024.
//

import XCTest
@testable import BeautyBlissApp

final class BeautyBlissAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginSuccess() throws {
        let expectation = self.expectation(description: "Login succeeds")
        
        AuthServices.login(email: "test@example.com", password: "password123") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil on success login")
                expectation.fulfill()
                
            case.failure(let error):
                XCTFail("Login should succeed, but failed with error \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchProductSuccess() throws {
        let expectation = self.expectation(description: "Fetch product succeeds")
        
        ProductServices.fetchProduct { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil on success login")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Fetch product should succeed, but failed with error \(error)")
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
