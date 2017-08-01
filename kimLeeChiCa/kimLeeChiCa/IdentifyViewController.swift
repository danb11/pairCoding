//
//  IdentifyViewController.swift
//  kimLeeChiCa
//
//  Created by woowabrothers on 2017. 7. 27..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class IdentifyViewController: UIViewController {
    
    var phoneNum = String()
    var identifyCheckNum = String()
    var network = Network()
    var timer : Timer? = nil
    var countTimer = 30

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var phoneNumbTextField: UITextField!
    @IBOutlet weak var identifyNumTextField: UITextField!
    @IBOutlet weak var identifyErrorLabel: UILabel!

    @IBOutlet weak var timerLabel: UILabel!
    
    enum identifyError {
        case noError
        case matchError
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identifyErrorLabel.isHidden = true
        requestButton.isEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func touchedRequestButton(_ sender: UIButton) {
        
        network.sendSlack()
        runTime()
        
    }

    @IBAction func touchedConfirmButton(_ sender: UIButton) {
        
        let verifyResult = verify()
        switch verifyResult {
        case .noError: break
        case .matchError:
            identifyErrorLabel.isHidden = false
            identifyErrorLabel.text = "※ 인증번호와 일치하지 않습니다."
        }
    }
    
    func update() {
        countTimer -= 1
        timerLabel.text = "00:\(countTimer)"
        if countTimer == 0 {
            timer?.invalidate()
            timer = nil
            countTimer = 30
            requestButton.isEnabled = true

        }
    }
    
    func runTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(IdentifyViewController.update)), userInfo: nil, repeats: true)
        requestButton.isEnabled = false
    }
    
    func verify() -> identifyError {
        
        if identifyCheckNum != phoneNum {
            return .matchError
        }
        return .noError
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
