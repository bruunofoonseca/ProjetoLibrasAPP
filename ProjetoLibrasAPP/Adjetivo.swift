//
//  Adjetivo.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 15/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Adjetivo : NSObject {
    
    var translator = Translator()
    
    override init(){
        super.init()
    }
    
    func tratarAdjetivo(adjetivo: Word, sujeito: Word) -> String
    {
        let adjetivoTratado: String!
        
        if sujeito.categories[0].text == "nome feminino" && sujeito.flexions[0].text == "sing"
        {
            adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Feminino singular")
        }
        else if sujeito.categories[0].text == "nome feminino" && sujeito.flexions[0].text == "plur"
        {
            adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Feminino plural")
        }
        else if sujeito.categories[0].text == "nome masculino" && sujeito.flexions[0].text == "sing"
        {
            adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Masculino singular")
        }
        else if sujeito.categories[0].text == "nome masculino" && sujeito.flexions[0].text == "plur"
        {
            adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Masculino plural")
        }
        else if sujeito.categories[0].text == "pronome"
        {
            adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: sujeito.flexions[0].text)
        }
        else
        {
            adjetivoTratado = adjetivo.text
        }
        
        return adjetivoTratado
    }
}
