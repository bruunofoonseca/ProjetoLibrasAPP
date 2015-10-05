//
//  Preposicao.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Preposicao: NSObject {
    
    override init(){
        super.init()
    }
    var palavra: [String] = []
    var fraseOrganizada : String = ""
    
    func Plistando(texto : [Word]) -> String {
        let path = NSBundle.mainBundle().pathForResource("Preposicao", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[0].text)?.valueForKey(texto[2].flexions[0].text) as AnyObject? as! String
        fraseOrganizada = test
        return fraseOrganizada
    }
}