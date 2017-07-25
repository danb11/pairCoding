//
//  photoFile.swift
//  photoApp
//
//  Created by woowabrothers on 2017. 7. 20..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation
import Photos

class Photo {
    
    var imageArray = [UIImage]()
    
    func grapPhoto() -> [UIImage] {
        let imgManager = PHImageManager.default()
        
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        
        let fetchoptions = PHFetchOptions()
        fetchoptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchoptions)
        
        {
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width:200, height:200), contentMode: .aspectFill, options: requestOption, resultHandler: {
                        image, error in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("no photo")
            }
        }
        return imageArray
    }
}
