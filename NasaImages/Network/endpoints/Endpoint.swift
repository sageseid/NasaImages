//
//  Endpoint.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation

protocol Endpoint {
    func createUrl() -> URLRequest
}

struct Endpoints {
    private init() {}
    
    struct NasaImages: Endpoint {
        private var path: String { "search" }
        
        init() {}
        
        func createUrl() -> URLRequest {
            return URLRequest(httpMethod: .get, path: path
            )
        }
    }
    
}
