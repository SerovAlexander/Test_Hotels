//
//  HotelInformationVC.swift
//
//  Created by Aleksandr Serov on 25.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class HotelInformationVC: UIViewController {
    
    //MARK: - Variable and Constants
    
    let networkService = NetworkService()
    var hotelInformation: HotelInformationModel?
    var id = Int()
    
    //MARK: - UI
    
    let hotelNameLabel = UILabel()
    let addressLabel = UILabel()
    let starsCountLabel = UILabel()
    let starImageView = UIImageView()
    let distanceLabel = UILabel()
    let pinImageView = UIImageView()
    let hotelImageView = UIImageView()
    let roomsCount = UILabel()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        getHotelInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupTitle(title: hotelInformation?.name ?? "")
        setupHotelImageView()
        setupHotelNameLabel()
        setupAddressLabel()
        setupStarImageView()
        setupStarsCountLabel()
        setupPinImageView()
        setupDistanceLabel()
    }
    
    //MARK:- Configure UI
    
    private func setupHotelNameLabel() {
        self.view.addSubview(hotelNameLabel)
        hotelNameLabel.font = UIFont.systemFont(ofSize: 20)
        hotelNameLabel.numberOfLines = 0
        hotelNameLabel.textAlignment = .center
        
        hotelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }
    }
    
    private func setupHotelImageView() {
        self.view.addSubview(hotelImageView)
        hotelImageView.contentMode = .scaleAspectFit
        
        hotelImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(200)
        }
    }
    
    private func setupAddressLabel() {
        self.view.addSubview(addressLabel)
        addressLabel.font = UIFont.systemFont(ofSize: 20)
        addressLabel.numberOfLines = 0
        addressLabel.textAlignment = .center
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelNameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            
        }
    }
    
    private func setupStarImageView() {
        self.view.addSubview(starImageView)
        starImageView.image = UIImage(named: "star")
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(5)
            make.centerX.equalTo(addressLabel)
            make.height.width.equalTo(25)
            
        }
    }
    
    private func setupStarsCountLabel() {
        self.view.addSubview(starsCountLabel)
        starsCountLabel.font = UIFont.systemFont(ofSize: 25)
        
        starsCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.left.equalTo(starImageView.snp.right).offset(3)
        }
    }
    
    private func setupPinImageView() {
        self.view.addSubview(pinImageView)
        pinImageView.image = UIImage(named: "pin")
        
        pinImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(starImageView.snp.bottom).offset(8)
            make.height.width.equalTo(25)
        }
    }
    
    private func setupDistanceLabel() {
        self.view.addSubview(distanceLabel)
        
        distanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pinImageView)
            make.left.equalTo(pinImageView.snp.right).offset(3)
            make.right.equalToSuperview().inset(5)
        }
    }
    
    //MARK:-  Private Methods
    
    private func getHotelInfo() {
        networkService.getHotelInformation(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let hotel):
                self.hotelInformation = hotel
                DispatchQueue.main.async {
                    self.configure()
                    self.configureImage()
                }
            case .failure( _):
                Alerts.presentAlert(view: self.view, viewController: self)
            }
        }
    }
    
    private func configure() {
        hotelNameLabel.text = hotelInformation?.name
        addressLabel.text = hotelInformation?.address
        if let starsCount = hotelInformation?.stars {
            starsCountLabel.text = String(starsCount)
            if let distance = hotelInformation?.distance {
                distanceLabel.text = String(distance) + " " + "км от центра"
            }
        }
    }
    
    private func configureImage() {
        hotelImageView.showActivityIndicator()
        if let image = hotelInformation?.image, !image.isEmpty {
            let imageString = "https://github.com/iMofas/ios-android-test/raw/master/" + image
            let url = URL(string: imageString)
            
            
            KingfisherManager.shared.retrieveImage(with: url!,
                                                   options: nil,
                                                   progressBlock: nil,
                                                   completionHandler: { [weak self] result in
                                                    guard let self = self else { return }
                                                    switch result {
                                                    case .success(let value):
                                                        self.setImage(value.image, self)
                                                    case .failure( _):
                                                        self.setStandartImage()
                                                        self.hotelImageView.stopActivitiIndicator()
                                                    }
                                                   })
        } else {
            setStandartImage()
            self.hotelImageView.stopActivitiIndicator()
        }
    }
    
    //MARK:- Helper methods
    
    private func setStandartImage(){
        hotelImageView.image = UIImage(named: "noImage")
    }
    
    private func setImage(_ image: KFCrossPlatformImage?, _ vc: HotelInformationVC) {
        if let imageHeight = image?.size.height , let imageWidth = image?.size.width {
            let rect = CGRect(x: 1.0, y: 1.0, width: imageWidth - 2.0, height: imageHeight - 2.0)
            if let firstCropimg = image?.cgImage?.cropping(to: rect) {
                self.hotelImageView.image = UIImage(cgImage: firstCropimg)
            } else {
                self.setStandartImage()
            }
        } else {
            self.setStandartImage()
        }
        self.hotelImageView.stopActivitiIndicator()
    }
    
    private func setupTitle(title: String) {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = title
        self.navigationItem.titleView = label
    }
    
}
