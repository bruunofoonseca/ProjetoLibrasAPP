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
        var posSubstantivoFlexion = -1
        arrayArtigos.removeAll()
        
        for (var i = 0; i < frase[0].mottos[0].categories.count; i++){
            if (frase[0].mottos[0].categories[i].text == "pronome"){
                posPronome = i
            }
            if (frase[0].mottos[0].categories[i].text == "verbo") && (frase[0].flexions[2].text == "Infinitivo Flexionado - 1ª singular"){
                posVerbo = i
            }
            else if (frase[0].mottos[0].categories[i].text == "nome feminino" || frase[0].mottos[0].categories[i].text == "nome masculino" ) && (posSubstantivo == -1){
                posSubstantivo = i
            }
        }
        
        if (posPronome != -1){
            posSubstantivoFlexion = relacionaFlexion(frase,posicaoFrase: 0, posicao: posPronome)
            arrayArtigos = objPronome.categorizarPronome(frase, posicao: 0, posCategoria: posPronome, posFlexion: posSubstantivoFlexion)
        }
        else if (posSubstantivo != -1){
            posSubstantivoFlexion = relacionaFlexion(frase, posicaoFrase: 0, posicao: posSubstantivo)
            if (frase[0].mottos[0].categories[posSubstantivo].text == "nome feminino") || (frase[0].mottos[0].categories[posSubstantivo].text == "nome masculino") && (posVerbo == -1) && (posSubstantivo != -1){
                //
                //                while (frase[0].flexions.count <= posSubstantivoFlexion) {
                //                    posSubstantivoFlexion =  posSubstantivoFlexion - 1
                //                }
                
                arrayArtigos = objSubstantivo.classificaSubstantivo(frase, posicao: 0, posCategoria: posSubstantivo, posFlexion: posSubstantivoFlexion)
            }
        }
        
        arrayArtigos.append(frase[0].text)
        return arrayArtigos
    }
    
    func relacionaFlexion(frase : [Word],posicaoFrase : Int, posicao : Int) -> Int {
        var posicaoFlexion = 0
        for (var i = 0; i < frase[posicaoFrase].flexions.count; i++){
            if (frase[posicaoFrase].mottos[0].categories[posicao].text == "pronome") && (frase[0].flexions[i].text == "Feminino singular") || (frase[posicaoFrase].flexions[i].text == "Masculino singular") || (frase[posicaoFrase].flexions[i].text == "Feminino plural") || (frase[posicaoFrase].flexions[i].text == "Masculino plural"){
                posicaoFlexion = i
            }
            else if (frase[posicaoFrase].mottos[0].categories[posicao].text == "nome feminino" || frase[posicaoFrase].mottos[0].categories[posicao].text == "nome masculino") && (frase[posicaoFrase].flexions[i].text == "sing" || frase[posicaoFrase].flexions[i].text == "plur"){
                posicaoFlexion = i
            }
        }
        
        return posicaoFlexion
    }
}
