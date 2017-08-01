//
//  ViewController.swift
//  kimLeeChiCa
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var id = String()
    var password = String()
    var passwordCheck = String()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    enum registerError {
        case noError
        case idEnglishError
        case idLengthError
        case passwordLengthError
        case idPasswordMatchError
        case passwordCheckError
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorMessageLabel.isHidden = true
        self.isAccessibilityElement = true
        idTextField.isAccessibilityElement = true
        passwordTextField.isAccessibilityElement = true
        reEnterPasswordTextField.isAccessibilityElement = true
        
        self.hidesBottomBarWhenPushed = true
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        reEnterPasswordTextField.delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func touchedRegister(_ sender: Any) {
        id = idTextField.text!
        password = passwordTextField.text!
        passwordCheck = reEnterPasswordTextField.text!
        let verifyResult = verify()
        switch verifyResult {
        case .noError: break
//            let keyChain = Keychain(service: "kimleechica", id: id)
//            
//            let userDic = ["password" : password] as [String : Any]
//            
//            do {
//                try keyChain.saveKeyChain(userDic: userDic)
//            } catch {
//                fatalError("Error saving keychain - \(error)")
//            }
        case .idEnglishError:
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "※ ID는 영어만 가능합니다."
        case .idLengthError:
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "※ ID를 4자 이상 입력해주세요."
        case .passwordLengthError:
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "※ PASSWORD를 6자 이상 입력해주세요."
        case .idPasswordMatchError:
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "※ PASSWORD에 ID는 포함될 수 없습니다."
        case .passwordCheckError:
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "※ PASSWORD가 일치하지 않습니다."
        }
        
    }
    
    func verify() -> registerError {
        
        if !containsOnlyLetters(input: id) {
            return .idEnglishError
        }
        if id.unicodeScalars.count < 4 {
            return .idLengthError
        }
        if password.unicodeScalars.count < 6 {
            return .passwordLengthError
        }
        if password.contains(id) {
            return .idPasswordMatchError
        }
        if password != passwordCheck {
            return .passwordCheckError
        }
        return .noError
        
    }

    func tap(gesture: UITapGestureRecognizer) {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        reEnterPasswordTextField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "identifySegue" {
//            let controller = segue.destination as! IdentifyViewController
//                
//            }
//        }

}

