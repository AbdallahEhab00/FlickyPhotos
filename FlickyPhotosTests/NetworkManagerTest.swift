//
//  NetworkManagerTest.swift
//  FlickyPhotosTests
//
//  Created by Abdallah Ehab on 21/05/2022.
//

import XCTest
@testable import FlickyPhotos

class NetworkManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllPhotosFromAPi(){
        let expectation = expectation(description: "waiting for Api response")
        
        NetworkManager.shared.getPhotos(page: 1, completion: { result in
            switch result{
            case .failure( _ ):
               XCTFail()
            case .success(let photos):
              XCTAssertNotNil(photos)
                expectation.fulfill()
            }
            
        })
        waitForExpectations(timeout: 5, handler: nil)
    }


}
