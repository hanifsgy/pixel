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
    
    
    // MARK: Properties
    fileprivate var cellId = "cellId"
    
    var dataShots = [Shots]()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // delegate collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShotsCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchData()
        setupView()
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
                        self.dataShots.append(shots)
                        DispatchQueue.main.async(execute: {
                            self.collectionView.reloadData()
                        })
                        
                    } catch let error {
                        print("error occured\(error)")
                    }

                }
            }
        }
    }
    
    func setupView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        NSLayoutConstraint.activate([
                collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
                collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
}

extension MainControllers: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataShots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShotsCell
        cell.dataShots = dataShots[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20, 0, 20, 0)
    }
    
}
