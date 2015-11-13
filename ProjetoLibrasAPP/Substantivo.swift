//
//  Substantivo.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Substantivo: NSObject {
    
    /**********     VARIÁVEIS   **********/
    
    var recebeArtigo : [String] = []
    var objArtigo = Artigo()
    var posicaoMotto = 0
    
    override init(){
        super.init()
    }
    
    func classificaSubstantivo(frase: [Word], posicao : Int, posCategoria : Int, posFlexion : Int) -> [String]{
        recebeArtigo.removeAll()
        recebeArtigo.removeAll()
        
        for(var i = 0; i < frase[posicao].mottos.count; i++){
            if (frase[posicao].text == frase[posicao].mottos[i].text){
                posicaoMotto = i
            }
        }
        
        if (frase[0].mottos[posicaoMotto].categories[posCategoria].text == "nome feminino") || (frase[0].mottos[posicaoMotto].categories[posCategoria].text == "nome masculino") || (frase[0].mottos[posicaoMotto].categories[posCategoria].text == "adjetivo"){
            recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao, posCategoria: posCategoria, posFlexion: posFlexion)
        }
        
        return recebeArtigo
    }
}