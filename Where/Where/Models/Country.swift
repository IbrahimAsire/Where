//
//  Country.swift
//  Where
//
//  Created by ibrahim asiri on 06/05/1443 AH.
//

import Foundation

struct Country: Decodable {
    var name: Name
    var capital: [String]
    var region: String
    var population: Int
}

struct Name: Codable {
    let common: String
}

