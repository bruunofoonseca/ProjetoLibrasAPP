//
//  ComplementoEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class ComplementoEstrutura : NSObject {
    
    /**********     VARIÁVEIS   **********/
    
    let objArtigo = Artigo()
    let objPronome = Pronome()
    let objVerbo = Verbo()
    let objAdjetivo = Adjetivo()
    let translator = Translator()
    var arrayArtigos : [String] = [""]
    var pronomeTonico : [String] = []
    var fraseClassificada : [Word] = []
    
    /**********     FUNÇÃO QUE TRATA O COMPLEMENTO DE ACORDO COM A FRASE   **********/
    
    func tratarComplemento(frase : [Word], preposicao : String) -> [String]{
        var posPronome = -1
        var posPronomeConfere = -1
        var posSubstantivo = -1
        var posVerbo = -1
        var posVerboCategoria1 = -1
        var posSubstantivoFlexion = -1
        var posAdjetivo = -1
        
        for (var i = 0; i < frase[2].categories.count; i++){
            if (frase[2].categories[i].text == "pronome"){
                posPronome = i
                posPronomeConfere = i
            }
            else if (frase[2].categories[i].text == "verbo") && (frase[2].flexions[i].text == "Infinitivo Flexionado - 1ª singular"){
                posVerbo = i
            }
            else if (frase[2].categories[i].text == "nome feminino" || frase[2].categories[i].text == "nome masculino" ) && (posSubstantivo == -1){
                posSubstantivo = i
            }
            else if frase[2].categories[i].text == "adjetivo"
            {
                posAdjetivo = i
            }
        }
        
        if (posPronome == -1){
            posPronome = 0
        }
        
        if (posVerbo == -1){
            posVerbo = 0
        }
        
        if (posSubstantivo != -1){
            posSubstantivoFlexion = posSubstantivo
        }
        else{
            posSubstantivo = 0
            posSubstantivoFlexion = 0
        }
        
        
        arrayArtigos.removeAll()
        
        for compCategory in frase[2].categories{
            if (compCategory.text == "pronome"){
                
                /**********     IRÁ COLOCAR ARTIGO CASO NÃO TENHA PREPOSIÇÃO QUANDO FOR PRONOME   **********/
                
                pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(frase, posicao: posVerboCategoria1))
                if (preposicao == "null"){
                    arrayArtigos = objPronome.categorizarPronome(frase, posicao: 2, posCategoria : 0, posFlexion: 0)
                }
                
                arrayArtigos.append(pronomeTonico[0] + ".")
                pronomeTonico.removeAll()
                
                return arrayArtigos
            }
                
            else if (compCategory.text == "verbo") && (posPronomeConfere == -1)
            {
                if (preposicao != "null") && (preposicao == "gerundio"){
                    arrayArtigos.append(translator.get_verbs(frase[2].text, flexion: "Infinitivo Flexionado - 1ª singular"))
                }
                else if (preposicao == "e"){
                    arrayArtigos.append(translator.get_verbs(frase[2].text, flexion: "Presente - 3ª singular") + ".")
                    return arrayArtigos
                }
            }
                
            else if (frase[2].categories[posSubstantivo].text == "nome feminino") || (frase[2].categories[posSubstantivo].text == "nome masculino") && (posPronomeConfere == -1){
                
                /**********     IRÁ COLOCAR ARTIGO CASO NÃO TENHA PREPOSIÇÃO QUANDO FOR SUBSTANTIVO   **********/
                
                while (frase[2].flexions.count <= posSubstantivoFlexion) {
                    posSubstantivoFlexion =  posSubstantivoFlexion - 1
                }
                
                if (preposicao == "null") || (preposicao == "") {
                    arrayArtigos = objArtigo.colocarArtigoDefinido(frase, posicao: 2, posCategoria : posSubstantivo, posFlexion : posSubstantivoFlexion)
                    arrayArtigos.append(frase[2].text + ".")
                }
            }
                
            else if (compCategory.text == "adjetivo")
            {
                arrayArtigos.append(objAdjetivo.tratarAdjetivo(frase[2], sujeito: frase[0]) + ".")
            }
            
        }
        
        return arrayArtigos
    }
}