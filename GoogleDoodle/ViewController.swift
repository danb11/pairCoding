//
//  ViewController.swift
//  GoogleDoodle
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 hyeongjong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataArray : Array<Dictionary<String,Any>> = []
    var imageDict = [Int:UIImage]()
    let jsonFile = GetFile()
    let imageFile = GetImageFile()
    var imageURL : [String] = []
    var temp = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //self.collectionView.prefetchDataSource = self
        //self.collectionView.isPrefetchingEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData(_:)), name: NSNotification.Name(rawValue: "getData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getImage(_:)), name: NSNotification.Name(rawValue: "getImage"), object: nil)
        
        jsonFile.request(string: "http://125.209.194.123/doodle.php")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(_ notification : Notification) {
        imageURL = jsonFile.imageURL
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        for i in  0..<imageURL.count {
            DispatchQueue.global().async {
                self.imageFile.request(string : self.imageURL[i], int: i)
            }
        }
    }

    func getImage (_ notification : Notification){
        print("getImage")

        DispatchQueue.main.sync{
            if let object = notification.object as? Image {
                self.imageDict[object.index] = object.imageFile
                let indexPath = IndexPath(item: object.index, section: 0)
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout/*,UICollectionViewDataSourcePrefetching*/ {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURL.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CustomCollectionViewCell
        
        cell.label.text = String(indexPath.row)
        
        if  self.imageDict.count > indexPath.row {
            cell.googleDoodle.image = self.imageDict[indexPath.row]
        }
        
        /*if cell.googleDoodle.image == nil {
            if  self.imageDict.count > indexPath.row {
                cell.googleDoodle.image = self.imageDict[indexPath.row]
            } else {
                DispatchQueue.global().async {
                    self.imageFile.request(string : self.imageURL[indexPath.row], int: indexPath.row)
                }
            }
        }*/
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 50)
    }
    
    /*func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(123)
        print("FETCHING")
        print(indexPaths,"indexPaths")
        for indexPath in indexPaths {
            print(indexPath,"indexPath")
            print(222)
            for i in 0..<indexPath.row {
                self.imageFile.request(string : self.imageURL[i])
            }
        }
    }*/
    
 
}
