//
//  NasaImagesServiceProtocol.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import Combine

protocol NasaImagesServiceProtocol {
    
    func fetchNasaImages() -> AnyPublisher<RootResponse, NetworkError>

}
