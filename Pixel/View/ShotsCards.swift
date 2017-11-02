//
//  ShotsCards.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 11/1/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import UIKit
import Cards
import SDWebImage
import FLAnimatedImage

class ShotsCards: UICollectionViewCell {
    
    var dataShots: Shots! {
        didSet {
            let urlimages = URL(string: dataShots.images)!
            if urlimages.absoluteString.contains(".gif") {
                self.titleGIF.isHidden = false
            } else {
                self.titleGIF.isHidden = true
            }
            self.imageShot.sd_setImage(with: urlimages, placeholderImage: nil)
            self.imageShot.sd_setShowActivityIndicatorView(true)
            self.imageShot.sd_setIndicatorStyle(.gray)
//            self.cardsArticle.title = dataShots.title
        }
    }
    
    let cardsArticle: CardArticle = {
       let card = CardArticle()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.masksToBounds = true
        card.clipsToBounds = true
        card.shadowBlur = 5
        card.shadowColor = UIColor.lightGray
        card.shadowOpacity = 0.5
        card.isUserInteractionEnabled = true
        return card
    }()
    
    let imageShot: FLAnimatedImageView = {
        let image = FLAnimatedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "sampleImage")
        return image
    }()
    
    let titleGIF: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.font = UIFont().robotoBold(size: 10)
        label.text = "GIF"
        label.textAlignment = .center
        label.isHidden = true
        label.layer.cornerRadius = 2
        label.isEditable = false
        label.isSelectable = false
        label.textContainerInset = UIEdgeInsetsMake(3, 2, 2, 2)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(cardsArticle)
        cardsArticle.addSubview(titleGIF)
//        cardsArticle.addSubview(imageShot)
        
        NSLayoutConstraint.activate([
            cardsArticle.widthAnchor.constraint(equalToConstant: 300),
            cardsArticle.heightAnchor.constraint(equalToConstant: 360),
            cardsArticle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            cardsArticle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleGIF.rightAnchor.constraint(equalTo: cardsArticle.rightAnchor, constant: -16),
            titleGIF.topAnchor.constraint(equalTo: cardsArticle.topAnchor, constant: 16),
            titleGIF.heightAnchor.constraint(equalToConstant: 18),
            titleGIF.widthAnchor.constraint(equalToConstant: 30),
            
//            imageShot.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            imageShot.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            imageShot.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            imageShot.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
        ])
        
    }
    
}
