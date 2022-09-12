//
//  MockNetworkManager.swift
//  NasaImagesTests
//
//  Created by Noel Obaseki on 12/09/2022.
//

import Foundation
import Combine
@testable import NasaImages

class MockNetworkManager: NetworkType {
    
    var failureError: NetworkError? = nil
    var successObject: AnyObject? = nil
    
    func get<T>(type: T.Type, endpoint: Endpoint, decoder: JSONDecoder) -> AnyPublisher<T, NetworkError> where T : Decodable {
        guard self.failureError == nil else {
            return Result.failure(self.failureError!).publisher.eraseToAnyPublisher()
        }
        
        return Result.success((self.successObject as? T)!).publisher.eraseToAnyPublisher()
    }
    
}
