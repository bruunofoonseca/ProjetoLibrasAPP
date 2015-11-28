//
//  Verbo.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Verbo: NSObject {
    
    /**********     VARIÁVEIS    **********/
    
    let api = Translator()
    var posicaoMottoSuj = 0
    var posicaoMottoVerb = 0
    
    override init(){
        super.init()
    }
    
    /**********     FUNÇÃO QUE CONJUGA O VERBO NO PRESENTE   **********/
    
    func conjugVerboSujeitoPresente(sujeito: Word, verbo: Word) -> String
    {
        var conjugVerbo = verbo.text
        
        posicaoMottoVerb = 0
        posicaoMottoSuj = 0
        
        for(var i = 0; i < sujeito.mottos.count; i++){
            if (sujeito.text == sujeito.mottos[i].text){
                posicaoMottoSuj = i
            }
        }
        
        for(var i = 0; i < verbo.mottos.count; i++)
        {
            if verbo.text == verbo.mottos[i].text
            {
                posicaoMottoVerb = i
            }
        }
        
        for sujCategoria in sujeito.mottos[posicaoMottoSuj].categories
        {
            if sujCategoria.text == "nome feminino" || sujCategoria.text == "nome masculino"
            {
                for sujFlexion in sujeito.flexions
                {
                    if sujFlexion.text == "sing" || sujFlexion.text == "Feminino singular" || sujFlexion.text == "Masculino singular"
                    {
                        conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 3ª singular")
                    }
                    else if sujFlexion.text == "plur" || sujFlexion.text == "Feminino plural" || sujFlexion.text == "Masculino plural"
                    {
                        conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 3ª plural")
                    }
                }
            }
            else if sujCategoria.text == "pronome"
            {
                if sujeito.text == "eu"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 1ª singular")
                }
                else if sujeito.text == "tu"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 2ª singular")
                }
                else if sujeito.text == "ele" || sujeito.text == "ela" || sujeito.text == "você"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 3ª singular")
                }
                else if sujeito.text == "nós" || sujeito.text == "nos"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 1ª plural")
                }
                else if sujeito.text == "vós"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 2ª plural")
                }
                else if sujeito.text == "eles" || sujeito.text == "elas" || sujeito.text == "vocês"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 3ª plural")
                }
                else{
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Presente - 3ª singular")
                }
            }
        }
        
        return conjugVerbo
    }
    
    /**********     FUNÇÃO QUE CONJUGA O VERBO NO PASSADO   **********/
    
    func conjugVerboSujeitoPassado(sujeito: Word, verbo: Word) -> String
    {
        var conjugVerbo = verbo.text
        
        for(var i = 0; i < sujeito.mottos.count; i++){
            if (sujeito.text == sujeito.mottos[i].text){
                posicaoMottoSuj = i
            }
        }
        
        for(var i = 0; i < verbo.mottos.count; i++)
        {
            if verbo.text == verbo.mottos[i].text
            {
                posicaoMottoVerb = i
            }
        }
        
        for sujCategoria in sujeito.mottos[posicaoMottoSuj].categories
        {
            if sujCategoria.text == "nome feminino" || sujCategoria.text == "nome masculino"
            {
                for sujFlexion in sujeito.flexions
                {
                    if sujFlexion.text == "sing" || sujFlexion.text == "Feminino singular" || sujFlexion.text == "Masculino singular"
                    {
                        conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 3ª singular")
                    }
                    else if sujFlexion.text == "plur" || sujFlexion.text == "Feminino plural" || sujFlexion.text == "Masculino plural"
                    {
                        conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 3ª plural")
                    }
                }
            }
            else if sujCategoria.text == "pronome"
            {
                if sujeito.text == "eu"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 1ª singular")
                }
                else if sujeito.text == "tu"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 2ª singular")
                }
                else if sujeito.text == "ele" || sujeito.text == "ela" || sujeito.text == "você"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 3ª singular")
                }
                else if sujeito.text == "nós" || sujeito.text == "nos"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 1ª plural")
                }
                else if sujeito.text == "vós"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 2ª plural")
                }
                else if sujeito.text == "eles" || sujeito.text == "elas" || sujeito.text == "vocês"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 3ª plural")
                }
                else{
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Pretérito Perfeito Simples - 3ª singular")
                }
            }
        }
        
        return conjugVerbo
    }
    
    /**********     FUNÇÃO QUE CONJUGA O VERBO NO FUTURO   **********/
    
    func conjugVerboSujeitoFuturo(sujeito: Word, verbo: Word) -> String
    {
        var conjugVerbo = verbo.text
        
        for(var i = 0; i < sujeito.mottos.count; i++){
            if (sujeito.text == sujeito.mottos[i].text){
                posicaoMottoSuj = i
            }
        }
        
        for(var i = 0; i < verbo.mottos.count; i++)
        {
            if verbo.text == verbo.mottos[i].text
            {
                posicaoMottoVerb = i
            }
        }
        
        for sujCategoria in sujeito.mottos[posicaoMottoSuj].categories
        {
            if sujCategoria.text == "nome feminino" || sujCategoria.text == "nome masculino"
            {
                for sujFlexion in sujeito.flexions
                {
                    if sujFlexion.text == "sing" || sujFlexion.text == "Feminino singular" || sujFlexion.text == "Masculino singular"
                    {
                        conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 3ª singular")
                    }
                    else if sujFlexion.text == "plur" || sujFlexion.text == "Feminino plural" || sujFlexion.text == "Masculino plural"
                    {
                        conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 3ª plural")
                    }
                }
            }
            else if sujCategoria.text == "pronome"
            {
                if sujeito.text == "eu"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 1ª singular")
                }
                else if sujeito.text == "tu"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 2ª singular")
                }
                else if sujeito.text == "ele" || sujeito.text == "ela" || sujeito.text == "você"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 3ª singular")
                }
                else if sujeito.text == "nós" || sujeito.text == "nos"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 1ª plural")
                }
                else if sujeito.text == "vós"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 2ª plural")
                }
                else if sujeito.text == "eles" || sujeito.text == "elas" || sujeito.text == "vocês"
                {
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 3ª plural")
                }
                else{
                    conjugVerbo = api.get_verbs(verbo.mottos[posicaoMottoVerb].text, flexion: "Futuro - 3ª singular")
                }
            }
        }
        
        return conjugVerbo
    }
}
