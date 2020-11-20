//
//  HotelListTVCell.swift
//
//  Created by Aleksandr Serov on 24.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit
import SnapKit

class HotelListTVCell: UITableViewCell {

 //MARK: - Variable and Constants

    let hotelNameLabel = UILabel()
    let adressLabel = UILabel()
    let starsCountLabel = UILabel()
    let starImageView = UIImageView()
    let distanceLabel = UILabel()
    let pinImageView = UIImageView()
    let roomsCountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createHotelNameLabel()
        createAdressLabel()
        createStarImage()
        createStarCountLabel()
        createPinImageView()
        createDistanceLabel()
        setupRoomsCountLabel() 
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public Methods

       func configure(with model: HotelModel) {
           hotelNameLabel.text = model.name
           adressLabel.text = model.address
           starsCountLabel.text = String(model.stars)
           distanceLabel.text = String(model.distance) + " " + "км от центра"
           let rooms = model.suitesAvailability.components(separatedBy: ":")
           roomsCountLabel.text = "Cвободных номеров:" + " " + String(rooms.count)
       }

    //MARK: - Configure UI

    private func createHotelNameLabel() {
        contentView.addSubview(hotelNameLabel)
        hotelNameLabel.numberOfLines = 0
        hotelNameLabel.font = UIFont.systemFont(ofSize: 18)
        hotelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(8)
            make.trailing.equalToSuperview().inset(40)
        }
    }

    private func createAdressLabel() {
        contentView.addSubview(adressLabel)
        adressLabel.numberOfLines = 0
        adressLabel.font = UIFont.systemFont(ofSize: 14)
        adressLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(8)
            make.trailing.equalToSuperview().inset(40)
        }
    }

    private func createStarImage() {
        contentView.addSubview(starImageView)
        starImageView.image = UIImage(named: "star")
        starImageView.contentMode = .scaleAspectFit
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(hotelNameLabel.snp.trailing).inset(4)
            make.top.equalTo(8)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }

    private func createStarCountLabel() {
        contentView.addSubview(starsCountLabel)
        starsCountLabel.font = UIFont.systemFont(ofSize: 15)
        starsCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(3)
            make.centerY.equalTo(starImageView)
            make.trailing.equalToSuperview().inset(3)
        }
    }

    private func createPinImageView() {
        contentView.addSubview(pinImageView)
        pinImageView.image = UIImage(named: "pin")
        pinImageView.contentMode = .scaleAspectFit
        pinImageView.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(3)
            make.leading.equalTo(8)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }

    private func createDistanceLabel() {
        contentView.addSubview(distanceLabel)
        distanceLabel.font = UIFont.systemFont(ofSize: 14)
        distanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pinImageView)
            make.leading.equalTo(pinImageView.snp.trailing).offset(3)
            make.trailing.equalToSuperview().inset(40)
            
        }
    }

    private func setupRoomsCountLabel() {
        contentView.addSubview(roomsCountLabel)
        roomsCountLabel.numberOfLines = 0
        roomsCountLabel.font = UIFont.systemFont(ofSize: 14)
        roomsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(pinImageView.snp.bottom).offset(3)
            make.leading.equalTo(8)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
