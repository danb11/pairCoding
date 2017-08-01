//
//  extension.swift
//  kimLeeChiCa
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

func containsOnlyLetters(input: String) -> Bool {
    for chr in input.characters {
        if (!(chr >= "a" && chr <= "z")) {
            return false
        }
    }
    return true
}
