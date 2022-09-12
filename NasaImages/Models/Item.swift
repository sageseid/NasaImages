//
//  Item.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation
struct Item: Codable {
    let data: [DataElement]
    let links: [Link]
}
