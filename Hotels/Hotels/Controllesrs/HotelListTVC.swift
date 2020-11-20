//
//  HotelListTVC.swift
//
//  Created by Aleksandr Serov on 23.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit

class HotelListTVC: UITableViewController {

    //MARK: - Variable and Constants

    let networkService = NetworkService()
    var hotels = [HotelModel]()
    var cellId = "CellId"

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hotels"
        addBarButtonItem(image: "sort")
        tableView.register(HotelListTVCell.self, forCellReuseIdentifier: cellId)
        networkService.getHotel(view: tableView) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let hotels):
                self.hotels = hotels
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure( _):
                Alerts.presentAlert(view: self.tableView, viewController: self)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HotelListTVCell else { return UITableViewCell() }
        let hotel = hotels[indexPath.row]
        cell.configure(with: hotel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotel = hotels[indexPath.row]
        let id = hotel.id
        let vc = HotelInformationVC()
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Private Methods
    
    private func addBarButtonItem(image: String) {
        let button = UIBarButtonItem(image: UIImage(named: image),
                                     style: .plain,
                                     target: self,
                                     action: #selector(presentVC))
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc private func presentVC() {
        let vc = SortVC()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}
    //MARK: - SortingDelegate

extension HotelListTVC: SortingDelegate {
    func sortingHotels(by: sortBy) {
        switch by {
        case .distanse:
            let sortedHotels = hotels.sorted { $0.distance < $1.distance }
            hotels = sortedHotels
            tableView.reloadData()
        case .rooms:
            let sortedHotels = hotels.sorted {
                let first = $0.suitesAvailability.components(separatedBy: ":")
                let second = $1.suitesAvailability.components(separatedBy: ":")
                
                return first.count > second.count
            }
            hotels = sortedHotels
            tableView.reloadData()
        }
    }
}
