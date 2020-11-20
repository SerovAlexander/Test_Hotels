//
//  HotelInformationsModel.swift
//
//  Created by Aleksandr Serov on 25.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import Foundation

struct HotelInformationModel: Codable {
    let id: Int?
    let name: String?
    let address: String?
    let stars: Int?
    let distance: Double?
    let image: String?
    let suitesAvailability: String?
    let lat: Double?
    let lon: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance, image
        case suitesAvailability = "suites_availability"
        case lat, lon
    }
}

