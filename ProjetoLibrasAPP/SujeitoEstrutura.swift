//
//  SujeitoEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class SujeitoEstrutura : NSObject {
    
    /**********     VARIÁVEIS     **********/

    let objSubstantivo = Substantivo()
    let objPronome = Pronome()
    var arrayArtigos : [String] = []
    var arrayPronome : [String] = []
    var fraseClassificada : [Word] = []
    

    /**********     FUNÇÃO QUE TRATA O SUJEITO    **********/

    func tratarSujeito(frase : [Word]) -> [String]{
        var posPronome = -1
        var posSubstantivo = -1
        var posVerbo = -1
        arrayArtigos.removeAll()
        
        for (var i = 0; i < frase[0].categories.count; i++){
            if (frase[0].categories[i].text == "pronome"){
                posPronome = i
            }
            if (frase[0].categories[i].text == "verbo") && (frase[0].flexions[i].text == "Infinitivo Flexionado - 1ª singular"){
                posVerbo = i
            }
            else if (frase[0].categories[i].text == "nome feminino" || frase[0].categories[i].text == "nome masculino" ) && (posSubstantivo == -1){
                posSubstantivo = i
            }
        }
        
        let posSubstantivoFlexion = posSubstantivo
        
        if (posPronome != -1){
            arrayArtigos = objPronome.categorizarPronome(frase, posicao: 0, posCategoria: posPronome, posFlexion: posSubstantivoFlexion)
        }
        else if (posSubstantivo != -1){
            if (frase[0].categories[posSubstantivo].text == "nome feminino") || (frase[0].categories[posSubstantivo].text == "nome masculino") && (posVerbo == -1) && (posSubstantivo != -1){
                var posSubstantivoFlexion = posSubstantivo
                
                while (frase[0].flexions.count <= posSubstantivoFlexion) {
                    posSubstantivoFlexion =  posSubstantivoFlexion - 1
                }
                
                print(frase[0].flexions.count)
                print(posSubstantivoFlexion)
                print(frase[0].flexions[posSubstantivoFlexion].text)
                arrayArtigos = objSubstantivo.classificaSubstantivo(frase, posicao: 0, posCategoria: posSubstantivo, posFlexion: posSubstantivoFlexion)
            }
        }
        
        arrayArtigos.append(frase[0].text)
        return arrayArtigos
    }
}

