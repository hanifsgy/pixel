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
import Spring
import Hero
import FLAnimatedImage
import Cards

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
    
    // makes view bounce header
    let viewDetail: UIView = {
       let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heroID = "viewDetail"
        return view
    }()
    
    let headerImages: FLAnimatedImageView = {
       let header = FLAnimatedImageView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.contentMode = .scaleToFill
        header.heroID = "header"
        header.isHidden = true
        return header
    }()
    
    let titleShots: UILabel = {
       let title = UILabel()
        title.isHidden = true
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont().robotoBold(size: 24)
        title.numberOfLines = 2
        title.textColor = UIColor.white
        title.adjustsFontSizeToFitWidth = true
        title.backgroundColor = UIColor.red
        title.heroID = "title"
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // delegate collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShotsCards.self, forCellWithReuseIdentifier: cellId)
        
        fetchData()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        
//        view.addSubview(viewDetail)
//        viewDetail.addSubview(headerImages)
//        viewDetail.addSubview(titleShots)
        
        NSLayoutConstraint.activate([
                collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
                collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
                
//                viewDetail.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                viewDetail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                viewDetail.widthAnchor.constraint(equalTo: view.widthAnchor),
//                viewDetail.heightAnchor.constraint(equalTo: view.heightAnchor),
//
//                headerImages.widthAnchor.constraint(equalTo: viewDetail.widthAnchor),
//                headerImages.heightAnchor.constraint(equalToConstant: 300),
//                headerImages.centerXAnchor.constraint(equalTo: viewDetail.centerXAnchor),
//                headerImages.topAnchor.constraint(equalTo: viewDetail.topAnchor),
//
//                titleShots.topAnchor.constraint(equalTo: headerImages.bottomAnchor, constant: 16),
//                titleShots.leftAnchor.constraint(equalTo: viewDetail.leftAnchor, constant: 16),
//                titleShots.widthAnchor.constraint(equalTo: viewDetail.widthAnchor, constant: -32),
//                titleShots.heightAnchor.constraint(equalToConstant: 48)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShotsCards
        cell.dataShots = dataShots[indexPath.item]
        cell.cardsArticle.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        cell.cardsArticle.addGestureRecognizer(tap)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20, 0, 20, 0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShotsCards
//        cell.dataShots = dataShots[indexPath.item]
//        let id = cell.dataShots.id
//        let viewDetailController = DetailShotController()
//        viewDetailController.id = id
//        viewDetailController.isHeroEnabled = true
//        viewDetailController.heroModalAnimationType = .zoom
//        HeroTransition().containerColor = .white
//        HeroTransition().transition(from: self, to: viewDetailController, in: UIApplication.shared.keyWindow!) { (finished) in
//            UIApplication.shared.keyWindow!.rootViewController = viewDetailController
//        }
//        self.viewDetail.isHidden = false
//        self.headerImages.isHidden = false
//        self.viewDetail.heroID = "header"
//        self.headerImages.heroID = "header"
//        self.viewDetail.heroModifiers = [.translate(y:100)]
//        self.headerImages.heroModifiers = [.translate(y:0)]
//        self.present(viewDetailController, animated: true, completion: nil)
//        let viewDetail = viewDetailController.view
//        cell.cardsArticle.shouldPresent(viewDetail, from: self)
//    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        let row = sender.view?.tag
        print(row!)
        let indexPath = NSIndexPath(row: row!, section: 0)
        print(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! ShotsCards
        cell.dataShots = dataShots[(indexPath as IndexPath).item]
        let id = cell.dataShots.id
        let viewDetailController = DetailShotController()
        viewDetailController.id = id
        let viewDetail = viewDetailController.view
        cell.cardsArticle.shouldPresent(viewDetail, from: self)
    }
}
