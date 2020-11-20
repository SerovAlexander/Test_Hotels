//
//  Model.swift
//
//  Created by Aleksandr Serov on 23.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import Foundation

struct HotelModel: Codable {
    let id: Int
    let name, address: String
    let stars: Int
    let distance: Double
    let suitesAvailability: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }
}
