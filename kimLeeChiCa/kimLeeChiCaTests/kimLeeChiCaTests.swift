//
//  kimLeeChiCaTests.swift
//  kimLeeChiCaTests
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
@testable import kimLeeChiCa

class kimLeeChiCaTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
        
        let dummy = registerViewController.view // force loading subviews and setting outlets
        
        registerViewController.viewDidLoad()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSaveKeychain() {
        let keyChain = Keychain(service: "kimleechica", id: "ilal")
        
        let userDic = ["password" : "1234", "cellPhone" : "01000000000", "dDate" : Date()] as [String : Any]
        
        do {
            try keyChain.saveKeyChain(userDic: userDic)
        } catch let xcttry as KeychainError {
            XCTAssertTrue(xcttry != KeychainError.unhandledError(status: noErr))
        } catch {
            XCTFail("wrong error")
        }
        
        var result = [String: Any]()
        do {
            result = try keyChain.loadKeychain()
        } catch let xcttry as KeychainError {
            XCTAssertTrue(xcttry == KeychainError.noUserDic || xcttry != KeychainError.unhandledError(status: noErr))
        } catch {
            XCTFail("wrong Error")
        }
        
        XCTAssertTrue(NSDictionary(dictionary: result).isEqual(to: userDic))
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testResterView() {
        let registerViewController = RegisterViewController()
        
        registerViewController.id = "1111"
        registerViewController.password = "123456"
        registerViewController.passwordCheck = "123456"
        XCTAssertTrue(registerViewController.verify() == RegisterViewController.registerError.idEnglishError)
        
        registerViewController.id = "aaa"
        registerViewController.password = "123456"
        registerViewController.passwordCheck = "123456"
        XCTAssertTrue(registerViewController.verify() == RegisterViewController.registerError.idLengthError)
        
        registerViewController.id = "aaaa"
        registerViewController.password = "123"
        registerViewController.passwordCheck = "123"
        XCTAssertTrue(registerViewController.verify() == RegisterViewController.registerError.passwordLengthError)
        
        registerViewController.id = "aaaa"
        registerViewController.password = "123456"
        registerViewController.passwordCheck = "12345"
        XCTAssertTrue(registerViewController.verify() == RegisterViewController.registerError.passwordCheckError)
        
        registerViewController.id = "aaaa"
        registerViewController.password = "aaaa12"
        registerViewController.passwordCheck = "aaaa12"
        XCTAssertTrue(registerViewController.verify() == RegisterViewController.registerError.idPasswordMatchError)
        
        registerViewController.id = "aaaa"
        registerViewController.password = "123456"
        registerViewController.passwordCheck = "123456"
        XCTAssertTrue(registerViewController.verify() == RegisterViewController.registerError.noError)
        
        registerViewController.idTextField.text = "aabb"
        registerViewController.passwordTextField.text = "123123"
        registerViewController.reEnterPasswordTextField.text = "123123"
        registerViewController.touchedRegister(Any)
    }
    
    func testIdentifyView() {
        let identifyViewController = IdentifyViewController()
        
        identifyViewController.phoneNum = "01000000000"
        identifyViewController.network.sendSlack()
        identifyViewController.identifyCheckNum = "9999999"
        
        XCTAssertTrue(identifyViewController.verify() == IdentifyViewController.identifyError.matchError)
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
