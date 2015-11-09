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
        var adjetivoTratado: String!
        
        for sujCategory in sujeito.mottos[0].categories
        {
            for sujFlexion in sujeito.flexions
            {
                if (sujCategory.text == "nome feminino") && (sujFlexion.text == "sing" || sujFlexion.text == "Feminino singular")
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Feminino singular")
                }
                else if sujCategory.text == "nome feminino" && sujFlexion.text == "plur"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Feminino plural")
                }
                else if sujCategory.text == "nome masculino" && sujFlexion.text == "sing"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Masculino singular")
                }
                else if sujCategory.text == "nome masculino" && sujFlexion.text == "plur"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: "Masculino plural")
                }
                else if sujCategory.text == "pronome" && sujFlexion.text == "Feminino singular"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: sujFlexion.text)
                }
                else if sujCategory.text == "pronome" && sujFlexion.text == "Masculino singular"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: sujFlexion.text)
                }
                else if sujCategory.text == "pronome" && sujFlexion.text == "Feminino plural"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: sujFlexion.text)
                }
                else if sujCategory.text == "pronome" && sujFlexion.text == "Masculino plural"
                {
                    adjetivoTratado = translator.get_adjectives(adjetivo.text, flexion: sujFlexion.text)
                }
            }
        }
        
        if adjetivoTratado == ""
        {
            adjetivoTratado = adjetivo.text
        }
        
        print(adjetivoTratado)
        
        return adjetivoTratado
    }
}
