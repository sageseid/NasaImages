//
//  NasaImagesService.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import Combine

final class NasaImagesService: NasaImagesServiceProtocol {
    
    private let networkManager: NetworkType
    
    init( networkManager: NetworkType = NetworkManager.sharedInstance) {
        self.networkManager = networkManager
    }
    
    func fetchNasaImages() -> AnyPublisher<RootResponse, NetworkError> {
        let endpoint = Endpoints.NasaImages()
        let decoder = JSONDecoder()
        
        let networkCallPublisher: AnyPublisher<RootResponse, NetworkError> = networkManager.get(type: RootResponse.self, endpoint: endpoint, decoder: decoder)
        
        return networkCallPublisher
    }
      
}
