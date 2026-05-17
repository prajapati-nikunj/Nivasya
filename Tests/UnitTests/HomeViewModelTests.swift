// File: Tests/UnitTests/HomeViewModelTests.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import XCTest
@testable import Nivasya

@MainActor
final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(sut.featuredProperties.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.selectedCategory)
    }
    
    func testLoadData() async {
        await sut.loadData()
        XCTAssertFalse(sut.featuredProperties.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }
}
