//
//  KeyChain.swift
//  kimLeeChiCa
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation
import UIKit
import Security



enum KeychainError: Error, Equatable {
    
    case noUserDic
    case unexpectedUserDicData
    case unexpectedItemData
    case unhandledError(status: OSStatus)
    
}

func == (lhs: KeychainError, rhs: KeychainError) -> Bool {
    switch (lhs, rhs) {
    case (.noUserDic, .noUserDic) : return true
    case (.unexpectedUserDicData, .unexpectedUserDicData) : return true
    case (.unexpectedItemData, .unexpectedItemData) : return true
    case (.unhandledError(let leftMessage), .unhandledError(let rightMessage)) :
        return leftMessage == rightMessage
    default : return false
        
    }
}




class Keychain {
    
    let service : String
    let id : String?
    
    init(service: String, id: String? = nil) {
        self.service = service
        self.id = id
    }
    
    func loadKeychain() throws -> [String: Any] {
        var query = keychainQuery(withService: service, id: id)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noUserDic }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String : AnyObject],
            let userDicData = existingItem[kSecValueData as String] as? Data,
            let userDic = NSKeyedUnarchiver.unarchiveObject(with: userDicData)
            else {
                throw KeychainError.unexpectedUserDicData
        }
        
        return userDic as! [String: Any]
    }
    

    func saveKeyChain(userDic: [String:Any]) throws {
        
        let encodedUserDic = NSKeyedArchiver.archivedData(withRootObject: userDic)
        
        do {
            // Check for an existing item in the keychain.
            try _ = loadKeychain()
            
            // Update the existing item with the new password.
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedUserDic as AnyObject?
            
            let query = keychainQuery(withService: service, id: id)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
        catch KeychainError.noUserDic {
            
            var newItem = keychainQuery(withService: service, id: id)
            
            newItem[kSecValueData as String] = encodedUserDic as AnyObject?
            let status = SecItemAdd(newItem as CFDictionary, nil)
            guard status == noErr else {throw KeychainError.unhandledError(status: status)}
        }
    }
    
    func keychainQuery(withService: String, id: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let id = id {
            query[kSecAttrAccount as String] = id as AnyObject?
        }

        return query
        
    }
}
