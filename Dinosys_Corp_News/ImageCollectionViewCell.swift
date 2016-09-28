//
//  ImageCollectionViewCell.swift
//  Dinosys
//
//  Created by Hung Nguyen on 9/26/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!

    func setImageView(imageName: String) {
        DispatchQueue.global().async {
            let image  = UIImage(named: imageName)
            DispatchQueue.main.async {
                self.imageView.image = image
                self.imageView.layer.shadowColor = UIColor.black.cgColor
                self.imageView.layer.shadowOpacity = 0.7
                self.imageView.layer.shadowOffset = CGSize.zero
                self.imageView.layer.shadowRadius = 10
            }
        }
    }
}
