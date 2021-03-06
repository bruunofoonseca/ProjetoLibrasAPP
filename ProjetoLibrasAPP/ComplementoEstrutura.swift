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
    let relacionar = SujeitoEstrutura()
    var arrayArtigos : [String] = [""]
    var pronomeTonico : [String] = []
    var fraseClassificada : [Word] = []
    var posicaoMotto = 0
    var posicaoMottoVerbo = 0
    
    
    /**********     FUNÇÃO QUE TRATA O COMPLEMENTO DE ACORDO COM A FRASE   **********/
    
    func tratarComplemento(frase : [Word], preposicao : String) -> [String]{
        var posPronome = -1
        var posPronomeConfere = -1
        var posSubstantivo = -1
        var posVerbo = -1
        var posVerboConfere = -1
        let posVerboCategoria1 = -1
        var posSubstantivoFlexion = -1
        
        posicaoMotto = 0
        posicaoMottoVerbo = 0
        
        
        for(var i = 0; i < frase[2].mottos.count; i++){
            if (frase[2].text == frase[2].mottos[i].text){
                posicaoMotto = i
            }
        }
        for(var i = 0; i < frase[1].mottos.count; i++){
            if (frase[1].text == frase[1].mottos[i].text){
                posicaoMottoVerbo = i
            }
        }
        
        
        for (var i = 0; i < frase[2].mottos[posicaoMotto].categories.count; i++){
            if (frase[2].mottos[posicaoMotto].categories[i].text == "pronome"){
                posPronome = i
                posPronomeConfere = i
            }
            else if (frase[2].mottos[posicaoMotto].categories[i].text == "verbo"){
                for (var j = 0; j < frase[2].flexions.count; j++){
                    if (frase[2].flexions[j].text == "Infinitivo Flexionado - 1ª singular"){
                        posVerbo = i
                        posVerboConfere = i
                    }
                }
            }
            else if (frase[2].mottos[posicaoMotto].categories[i].text == "nome feminino" || frase[2].mottos[posicaoMotto].categories[i].text == "nome masculino" ) && (posSubstantivo == -1){
                posSubstantivo = i
            }
        }
        
        if (posPronome == -1){
            posPronomeConfere = posPronome
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
        
        for compCategory in frase[2].mottos[posicaoMotto].categories{
            if (compCategory.text == "adjetivo")
            {
                arrayArtigos.append(objAdjetivo.tratarAdjetivo(frase[2], sujeito: frase[0]) + ".")
                return arrayArtigos
            }
            else if (compCategory.text == "pronome"){
                
                /**********     IRÁ COLOCAR ARTIGO CASO NÃO TENHA PREPOSIÇÃO QUANDO FOR PRONOME   **********/
                
                pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(frase, posicao: posVerboCategoria1, posicaoDoPai: posicaoMottoVerbo))
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
                    arrayArtigos.append(translator.get_verbs(frase[2].text, flexion: "Gerundio") + ".")
                    return arrayArtigos
                }
                else if (preposicao == "e") {
                    arrayArtigos.append(objVerbo.conjugVerboSujeitoPassado(frase[0], verbo: frase[2]) + ".")
                    return arrayArtigos
                }
                else if(preposicao == "enquanto"){
                    arrayArtigos.append(translator.get_verbs(frase[2].mottos[posicaoMotto].text, flexion: "Pretérito Imperfeito - 1ª singular") + ".")
                }
                else{
                    arrayArtigos.append(frase[2].text + ".")
                    return arrayArtigos
                }
            }
            else if (frase[2].mottos[posicaoMotto].categories[posSubstantivo].text == "nome feminino") || (frase[2].mottos[posicaoMotto].categories[posSubstantivo].text == "nome masculino") && (posPronomeConfere == -1) && (posVerboConfere == -1){
                
                /**********     IRÁ COLOCAR ARTIGO CASO NÃO TENHA PREPOSIÇÃO QUANDO FOR SUBSTANTIVO   **********/
                
                posSubstantivoFlexion = relacionar.relacionaFlexion(frase, posicaoFrase: 2, posicao: posSubstantivo , posicaoDoPai: posicaoMotto)
                
                if (preposicao == "null") || (preposicao == "") {
                    arrayArtigos = objArtigo.colocarArtigoDefinido(frase, posicao: 2, posCategoria : posSubstantivo, posFlexion : posSubstantivoFlexion)
                    arrayArtigos.append(frase[2].text + ".")
                }
                else
                {
                    arrayArtigos.append(frase[2].text + ".")
                }
                
                return arrayArtigos
            }
            else if(compCategory.text == "advérbio")&&(posPronomeConfere == -1){
                arrayArtigos.append(frase[2].text + ".")
                return arrayArtigos
            }
        }
        
        arrayArtigos.append(frase[2].text + ".")
        return arrayArtigos
    }
}