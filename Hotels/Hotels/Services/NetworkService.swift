//
//  NetworkServise.swift
//
//  Created by Aleksandr Serov on 23.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {

    public func getHotel(view: UIView, completion: @escaping (Result<[HotelModel], Error>) -> Void) {
        AF.request(Inner.fetchlHotelUrl).responseJSON { response in
            guard let data = response.data else {
                if case let .failure(error) = response.result {
                    let error = error as NSError
                    completion(.failure(error))
                }
                return }
            if let hotels = try? JSONDecoder().decode([HotelModel].self, from: data) {
                completion(.success(hotels))
            }
        }
    }

    public func getHotelInformation(id: Int, completion: @escaping (Result<HotelInformationModel, Error>) -> Void) {
        let url = self.createUrl(with: id)
        AF.request(url).responseJSON { response  in
            guard let data = response.data else {
                if case let .failure(error) = response.result {
                    let error = error as NSError
                    completion(.failure(error))
                }
                return }
            if let hotel = try? JSONDecoder().decode(HotelInformationModel?.self, from: data) {
                completion(.success(hotel))
            }
        }
    }

    private struct Inner {
        static let fetchlHotelUrl = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
        static let fetchHotelInfoUrl = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/"
    }

    private func createUrl(with id: Int) -> String {
        let url = Inner.fetchHotelInfoUrl + String(id) + ".json"

        return url
    }
}
