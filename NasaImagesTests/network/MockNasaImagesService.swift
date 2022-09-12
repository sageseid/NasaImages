//
//  MockNasaImagesService.swift
//  NasaImagesTests
//
//  Created by Noel Obaseki on 12/09/2022.
//

import Foundation
import Combine
@testable import NasaImages

class MockNasaImagesService: NasaImagesServiceProtocol {
    
    func fetchNasaImages() -> AnyPublisher<RootResponse, NetworkError> {
        return nasaResponseSubject.eraseToAnyPublisher()
    }
    
   
    
    let nasaResponseSubject = PassthroughSubject<RootResponse, NetworkError>()
    
    let nasaResponseResult =  RootResponse(collection: CollectionModel(items: [Item(data: [DataElement(title: "test", photographer: "test", date_created: "2002-03-20T00:00:00Z", description: "test")], links: [Link(href: "https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/ARC-2002-ACD02-0056-22~thumb.jpg")])]))

    

    
    func fetchNasaImagesResponse() {
        nasaResponseSubject.send(nasaResponseResult)
    }
    

}
