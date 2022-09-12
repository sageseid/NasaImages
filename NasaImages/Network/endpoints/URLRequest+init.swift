//
//  URLRequest+init.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//
//https://images-api.nasa.gov/search?q=%22%22

import Foundation

extension URLRequest {
   
    init(httpMethod: HTTPRequestMethod, path: String){
        let urlQueryItems = [URLQueryItem(name: "q", value: Constants.API.searchParam)]
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.API.baseUrl
        components.path = "/\(path)"
        components.queryItems = urlQueryItems
        let url = components.url!
        //print("url \(url)")
        self.init(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        self.httpMethod = httpMethod.rawValue
    }
}
