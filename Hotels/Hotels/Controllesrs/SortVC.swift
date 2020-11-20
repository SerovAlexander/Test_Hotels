//
//  SortVC.swift
//
//  Created by Aleksandr Serov on 27.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit

//MARK: - Sorting Delegate
protocol SortingDelegate {
    func sortingHotels(by: sortBy)
}

enum sortBy {
    case rooms
    case distanse
}

class SortVC: UITableViewController {
    
    //MARK: - UI
    let firstCell = UITableViewCell()
    let secondCell = UITableViewCell()
    var firstText = UILabel()
    var secondText = UILabel()
    
    //MARK: - Variable and Constants
    
    var delegate: SortingDelegate?
    var cells = [UITableViewCell]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        setupCell()
    }
    
    // MARK: - Setup UI
    
    private func setupCell() {
        
        self.firstCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.firstText = UILabel(frame: self.firstCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        self.firstText.tintColor = .black
        self.firstText.text = "Растояние от центра города"
        self.firstCell.addSubview(self.firstText)
        cells.append(firstCell)
        
        self.secondCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.secondText = UILabel(frame: self.secondCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        self.secondText.tintColor = .black
        self.secondText.text = "Количество свободных номеров"
        self.secondCell.addSubview(self.secondText)
        cells.append(secondCell)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0: return self.firstCell  
        case 1: return self.secondCell
        default: fatalError("Unknown row in section 0")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
        
        case 0:
            delegate?.sortingHotels(by: .distanse)
            self.dismiss(animated: true, completion: nil)
            
        case 1:
            delegate?.sortingHotels(by: .rooms)
            self.dismiss(animated: true, completion: nil)
            
        default: fatalError("Unknown row in section 0")
        }
    }
}
