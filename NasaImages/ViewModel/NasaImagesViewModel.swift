//
//  NasaImagesViewModel.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
import Combine

class NasaImagesViewModel: ObservableObject {
    
    private let nasaImagesService: NasaImagesServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published var errorMessage: String? = nil
    @Published var NasaData: [Item] = []

    init(nasaImagesService: NasaImagesServiceProtocol = NasaImagesService()){
        self.nasaImagesService = nasaImagesService
        fetchNasaData()
    }
    
    func fetchNasaData(){
        nasaImagesService.fetchNasaImages()
            .sink { (completion) in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.errorMessage = NetworkError.getErrorMsg(error) 
                }
            }receiveValue: { [weak self] (res) in
                self?.NasaData = res.collection.items
            }.store(in: &cancellableSet)
    }
    
}
