//
//  PhotoCollectionViewCell.swift
//  photoApp
//
//  Created by woowabrothers on 2017. 7. 20..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageCell: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = 3.0
            self.layer.borderColor = isSelected ? UIColor.gray.cgColor : UIColor.clear.cgColor
        }
    }
}
