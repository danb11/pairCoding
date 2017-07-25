//
//  File.swift
//  GoogleDoodle
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 hyeongjong. All rights reserved.
//

import Foundation

import Foundation

class GetFile {
    
    var imageURL = [String]()
    
    init() {
    }
    
    func request(string: String) {
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
        URL(string: string)!) {
            (data, response, error) in
            do {
                //let jsonData = Data(base64Encoded: string)!
                let jsonData = data!
                let jsonArray = try (JSONSerialization.jsonObject(with: jsonData) as! Array<Dictionary<String,Any>>)
                for i in 0..<jsonArray.count {
                    self.imageURL.append(jsonArray[i]["image"] as! String)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            NotificationCenter.default.post(name: NSNotification.Name("getData"), object: nil)
            }.resume()
    }
}


