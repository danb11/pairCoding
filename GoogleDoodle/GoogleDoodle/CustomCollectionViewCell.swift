//
//  CustomCollectionViewCell.swift
//  GoogleDoodle
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 hyeongjong. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var googleDoodle: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
