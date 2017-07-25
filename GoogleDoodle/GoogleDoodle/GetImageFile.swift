//
//  GetImage.swift
//  GoogleDoodle
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 hyeongjong. All rights reserved.
//

import Foundation
import UIKit

class GetImageFile {
    func request(string: String, int: Int) {
        var image = Image()
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
        URL(string: string)!) {
            (data, response, error) in
            do {
                image.imageFile = UIImage(data: data!)!
                image.index = int
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            NotificationCenter.default.post(name: NSNotification.Name("getImage"), object: image)
            }.resume()
    }
}

struct Image {
    var imageFile = UIImage()
    var index = 0
}
