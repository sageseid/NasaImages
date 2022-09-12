//
//  NetworkType.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import Combine


protocol NetworkType {
    
    func get<T>(type: T.Type,
                    endpoint: Endpoint,
                    decoder: JSONDecoder
        ) -> AnyPublisher<T, NetworkError> where T: Decodable
    
}
