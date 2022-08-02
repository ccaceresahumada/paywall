//
//  PaywallViewModelTests.swift
//  PaywallTests
//
//  Copyright © 2020 Disney Streaming. All rights reserved.
//

import XCTest
@testable import Paywall

class PaywallViewModelTests: XCTestCase, PaywallServiceInjector {
    
    // MARK: - Private properties
    
    private var actualNetworkService: PaywallService?
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        actualNetworkService = paywallService
    }
    
    override func tearDown() {
        super.tearDown()
        if let actualNetworkService = actualNetworkService {
            replacePaywallServiceReference(actualNetworkService)
        }
    }
    
    // MARK: - Tests
    
    func testGetCurrentTypeForDisney() {
        verifyType(for: .disney)
        verifyType(for: .espn)
    }
    
    func testDataLoad() {
        verifyDataLoad(for: .disney)
        verifyDataLoad(for: .espn)
    }

    func testGetBackgroundImageName() {
        verifyBackgroundImage(for: .disney)
        verifyBackgroundImage(for: .espn)
    }
    
    // MARK: - Utils
    
    private func loadTestData(forType type: PaywallType) -> PaywallLayout? {
        guard let url = Bundle.main.url(forResource: "scripts/\(type.rawValue)/response", withExtension: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(PaywallLayout.self, from: data)
            return jsonData
        } catch {
            print("Error: \(error)")
        }
        
        return nil
    }
    
    private func verifyType(for type: PaywallType) {
        let viewModel = PaywallViewModel(type: type, delegate: nil)
        XCTAssertEqual(viewModel.getCurrentType(), type)
    }
    
    private func verifyBackgroundImage(for type: PaywallType) {
        // Given
        let expectedName = type == .disney ? "splash.png" : "espn.jpg"
        let testData = loadTestData(forType: type)
        let mockService = PaywallService(testData: testData)
        replacePaywallServiceReference(mockService)
        let queue = DispatchQueue(label: "PaywallViewModelTests")
        let viewModel = PaywallViewModel(type: type, delegate: nil)
        
        // When
        viewModel.reloadData(queue: queue)
        queue.sync {} // Inject a sync closure to "wait" until the reload ends before asserting
        
        // Assert
        XCTAssertEqual(viewModel.getBackgroundImageName(), expectedName)
    }
    
    private func verifyDataLoad(for type: PaywallType) {
        // Given
        let testData = loadTestData(forType: type)
        let mockService = PaywallService(testData: testData)
        replacePaywallServiceReference(mockService)
        let queue = DispatchQueue(label: "PaywallViewModelTests")
        let viewModel = PaywallViewModel(type: type, delegate: nil)
        
        // When
        viewModel.reloadData(queue: queue)
        queue.sync {} // Inject a sync closure to "wait" until the reload ends before asserting
        
        // Assert
        XCTAssertNotNil(viewModel.paywall)
        XCTAssertEqual(viewModel.getCurrentType(), type)
    }
}
