//
//  album.swift
//  photoApp
//
//  Created by woowabrothers on 2017. 7. 20..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


import Foundation
import Photos

class Album {
    
    var albumArray = [String]()
    
    func grapAlbum() -> [String] {
        let imgManager = PHImageManager.default()
        
//        let requestOption = PHImageRequestOptions()
//        requestOption.isSynchronous = true
//        requestOption.deliveryMode = .highQualityFormat
        
        let fetchoptions = PHFetchOptions()
//        fetchoptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: fetchoptions)
            //         PHAsset.fetchAssets(with: .image, options: fetchoptions)
        {
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    let collection = fetchResult[i]
                    let title = collection.localizedTitle
                    print(title)
                    albumArray.append(title!)
                    /*if collection.estimatedAssetCount != nil {
                        let count = collection.estimatedAssetCount
                    }*/
                }
            } else {
                print("no library")
            }
        }
    return albumArray
    }
}
