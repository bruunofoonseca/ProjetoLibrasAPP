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
            adjetivoTratado = translator.buscaAdjetivo(adjetivo.text, flexao: "Feminino singular")
        }
        else if sujeito.categories[0].text == "nome feminino" && sujeito.flexions[0].text == "plur"
        {
            adjetivoTratado = translator.buscaAdjetivo(adjetivo.text, flexao: "Feminino plural")
        }
        else if sujeito.categories[0].text == "nome masculino" && sujeito.flexions[0].text == "sing"
        {
            adjetivoTratado = translator.buscaAdjetivo(adjetivo.text, flexao: "Masculino singular")
        }
        else if sujeito.categories[0].text == "nome masculino" && sujeito.flexions[0].text == "plur"
        {
            adjetivoTratado = translator.buscaAdjetivo(adjetivo.text, flexao: "Masculino plural")
        }
        else if sujeito.categories[0].text == "pronome"
        {
            adjetivoTratado = translator.buscaAdjetivo(adjetivo.text, flexao: sujeito.flexions[0].text)
        }
        else
        {
            adjetivoTratado = adjetivo.text
        }
        
        return adjetivoTratado
    }
}
