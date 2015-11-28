//
//  VerboEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation

class VerboEstrutura : NSObject {
    
    /**********     VARIÁVEIS   **********/
    
    let api = Translator()
    let objVerbo = Verbo()
    var defVerbo: [String] = []
    let objPreposicao = Preposicao()
    
    
    /**********     FUNÇÃO QUE TRATA O VERBO DE ACORDO COM O SUJEITO E INSERE PREPOSIÇÃO   **********/
    
    func tratarVerbo(frase: [Word], tempo: Int) -> [String]
    {
        defVerbo.removeAll()
        
        var posVerbo = -1
        
        for (var i = 0; i < frase[1].mottos[0].categories.count; i++)
        {
            if (frase[1].mottos[0].categories[i].text == "verbo")
            {
                for flexion in frase[1].flexions{
                    if flexion.text == "Infinitivo Flexionado - 1ª singular"{
                        posVerbo = i
                    }
                }
            }
        }
        
        for _ in frase[1].mottos[0].categories{
            
            if tempo == 0
            {
                for category in frase[1].mottos[0].categories
                {
                    if category.text == "verbo"
                    {
                        defVerbo.append(objVerbo.conjugVerboSujeitoPresente(frase[0], verbo: frase[1]))
                        defVerbo.append(objPreposicao.inserePreposicao(frase, posicao: posVerbo))
                        return defVerbo
                    }
                }
            }
            else if tempo == 1
            {
                for category in frase[1].mottos[0].categories
                {
                    if category.text == "verbo"
                    {
                        defVerbo.append(objVerbo.conjugVerboSujeitoPassado(frase[0], verbo: frase[1]))
                        defVerbo.append(objPreposicao.inserePreposicao(frase, posicao: posVerbo))
                        return defVerbo
                    }
                }
            }
            else if tempo == 2
            {
                for category in frase[1].mottos[0].categories
                {
                    if category.text == "verbo"
                    {
                        defVerbo.append(objVerbo.conjugVerboSujeitoFuturo(frase[0], verbo: frase[1]))
                        defVerbo.append(objPreposicao.inserePreposicao(frase, posicao: posVerbo))
                        return defVerbo
                    }
                }
            }
            
            if defVerbo.count == 0
            {
                defVerbo.append(frase[1].text)
                defVerbo.append(objPreposicao.inserePreposicao(frase, posicao: posVerbo))
            }
        }
        
        return defVerbo
    }
}