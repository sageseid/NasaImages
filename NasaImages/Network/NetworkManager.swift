//
//  NetworkManager.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import Combine

class NetworkManager: NetworkType {
    static let sharedInstance = NetworkManager()
    
    func get<T>(type: T.Type, endpoint: Endpoint, decoder: JSONDecoder) -> AnyPublisher<T, NetworkError> where T : Decodable {
        let urlRequest = endpoint.createUrl()
        
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
           .mapError { NetworkError.mapConnectivityError($0) }
            .tryMap({ (apiResponse) -> T in
                //print("--> data: \(String(describing: String(data: apiResponse.data, encoding: .utf8)))")
                if let httpUrlResponse = apiResponse.response as? HTTPURLResponse,
                   httpUrlResponse.statusCode != 200 {
                    throw NetworkError.mapHTTPStatusError( statusCode: httpUrlResponse.statusCode)
                }
                return try decoder.decode(T.self, from: apiResponse.data)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .mapError { NetworkError.mapConnectivityError($0) }
            .eraseToAnyPublisher()
    }
    
}
