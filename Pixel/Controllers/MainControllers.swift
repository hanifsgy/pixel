//
//  MainControllers.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 10/31/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class MainControllers: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
    }
    
    func fetchData() {
        let url = Services.shotsURL + Client.clientAccessToken
        print(url)
    
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON { (respond) in
            if((respond.result.value) != nil) {
                let json = JSON(respond.result.value!)
                for datas in json.array! {
                    do {
                        let shots = try Shots(json: datas)
                        let images = shots.images
                        print(images)
                    } catch let error {
                        print("error occured\(error)")
                    }

                }
            }
        }
        
    }
    
    
}
