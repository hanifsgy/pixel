//
//  ShotsCell.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 10/31/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class ShotsCell: UICollectionViewCell {
    
  
    var dataShots: Shots! {
        didSet {
            let urlimages = URL(string: dataShots.images)!
            print(urlimages)
            self.imageShot.sd_setImage(with: urlimages, placeholderImage: nil)
            self.titleShots.text = dataShots.title
        }
    }
    
    
    let imageShot: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "sampleImage")
        return image
    }()
    
    let titleShots: UILabel = {
       let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.textColor = UIColor.white
        likes.text = "Fluent inspired E-mail app "
        likes.font = UIFont().robotoLight(size: 18)
        likes.numberOfLines = 2
        likes.adjustsFontSizeToFitWidth = true
        return likes
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(imageShot)
        imageShot.addSubview(titleShots)
        
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect:contentView.bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
        
        NSLayoutConstraint.activate([
                imageShot.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                imageShot.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                imageShot.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                imageShot.heightAnchor.constraint(equalToConstant: 400),
                
                titleShots.bottomAnchor.constraint(equalTo: imageShot.bottomAnchor, constant: -16),
                titleShots.leftAnchor.constraint(equalTo: imageShot.leftAnchor, constant: 16),
                titleShots.widthAnchor.constraint(equalTo: imageShot.widthAnchor, constant: -32),
                titleShots.heightAnchor.constraint(equalToConstant: 48)
            
        ])
        
    }
    
    
}