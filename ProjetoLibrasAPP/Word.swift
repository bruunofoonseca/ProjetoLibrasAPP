//
//  File.swift
//  Testesss
//
//  Created by Bruno Pereira dos Santos on 18/09/15.
//  Copyright © 2015 Gabriela Gomes Pires. All rights reserved.
//

import UIKit

class Word: NSObject {
    
    var id:Int!
    var text:String!
    var motto:String!
    var categories:[Category]!
    var flexions:[Flexion]!
    
    override init() {
        categories = []
        flexions = []
    }
    
}