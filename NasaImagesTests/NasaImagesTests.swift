//
//  NasaImagesTests.swift
//  NasaImagesTests
//
//  Created by Noel Obaseki on 09/09/2022.
//

import XCTest
import Combine
@testable import NasaImages

class NasaImagesTests: XCTestCase {
    
    var mockedNetworkManager: MockNetworkManager!
    var mockedService: NasaImagesService!
    
    var cancellableSet: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockedNetworkManager = MockNetworkManager()
        mockedService = NasaImagesService(networkManager: mockedNetworkManager) 
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockedNetworkManager = nil
        mockedService = nil
    }
    
    func testDataFetching() throws {
        mockedService.fetchNasaImages()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTFail(error.localizedDescription)
                case .finished:break
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response)
                XCTAssertEqual(response.collection.items[0].data[0].photographer, "Tom Trower")
            }).store(in: &cancellableSet)
        waitForExpectations(timeout: 1, handler: nil)
    }


}
