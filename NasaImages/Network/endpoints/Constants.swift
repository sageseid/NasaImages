//
//  Constants.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation

struct Constants {
    struct API {
        static let baseUrl: String = "images-api.nasa.gov"
        static let searchParam: String = "%22%22".removingPercentEncoding!
    }
}
