//
//  Network.swift
//  kimLeeChiCa
//
//  Created by woowabrothers on 2017. 7. 27..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Network {
     var identifyNum = String()
    
    func sendSlack() {

        identifyNum = makeRanNum()

        let myUrl = URL(string: "https://hooks.slack.com/services/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");
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let postString = "payload={\"text\": \"\(identifyNum)\",\"username\":\"kimlee\" }"
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                return
            }
        }
        task.resume()
    }
    
    func makeRanNum() -> String{
        var ranNum = String()

        for _ in 0...5 {
            let randomNo: UInt32 = arc4random_uniform(10);
            ranNum += String(randomNo)
        }
        
        return ranNum
    }
}
