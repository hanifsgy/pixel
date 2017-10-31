//
//  DetailShotController.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 10/31/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Spring
import Hero
import FLAnimatedImage
import SDWebImage

class DetailShotController: UIViewController {
    
    var id:Int!
    
    let closeButton: UIButton = {
       let close = UIButton(type: .custom)
        let image = #imageLiteral(resourceName: "closeButton")
        close.setImage(image, for: UIControlState())
        close.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.isUserInteractionEnabled = true
        return close
    }()
    
    let imageShots: FLAnimatedImageView = {
       let image = FLAnimatedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupView() {
        view.addSubview(closeButton)
        closeButton.layer.zPosition = 2
        view.addSubview(imageShots)
        view.backgroundColor = UIColor.white
        NSLayoutConstraint.activate([
                closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
                closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
                closeButton.widthAnchor.constraint(equalToConstant: 32),
                closeButton.heightAnchor.constraint(equalToConstant: 32),
                
                imageShots.topAnchor.constraint(equalTo: view.topAnchor),
                imageShots.widthAnchor.constraint(equalTo: view.widthAnchor),
                imageShots.heightAnchor.constraint(equalToConstant: 300),
                imageShots.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                
        ])
        
        
        
    }
    
    func fetchData() {
        let url = Services.getShot + "\(id!)" + "?access_token=" + Client.clientAccessToken
        print(url)
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            if((response.result.value) != nil) {
                let json = JSON(response.result.value!)
                print(json)
                if let images = json["images"]["hidpi"].string {
                    let url = URL(string: images)!
                    self.imageShots.sd_setImage(with: url, placeholderImage: nil)
                    self.imageShots.sd_setShowActivityIndicatorView(true)
                    self.imageShots.sd_setIndicatorStyle(.gray)
                }
            }
        }
        
    }
    
    @objc func handleClose() {
        let homeController = MainControllers()
        homeController.isHeroEnabled = true
        homeController.heroModalAnimationType = .zoomOut
        HeroTransition().transition(from: self, to: homeController, in: UIApplication.shared.keyWindow!) { (finished) in
            UIApplication.shared.keyWindow!.rootViewController = homeController
        }
    }
    
}
