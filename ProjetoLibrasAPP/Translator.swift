//
//  Translator.swift
//  Testesss
//
//  Created by Bruno Pereira dos Santos on 18/09/15.
//  Copyright © 2015 Gabriela Gomes Pires. All rights reserved.
//

import UIKit

class Translator: NSObject {
    
    var WordsList:[Word]
    
    override init() {
        
        // Código para teste (REMOVER DEPOIS)
        WordsList = []
        
        var newWord:Word
        var newFlexion:Flexion
        var newCategory:Category
        var flexions:[String]
        var categories:[String]
        
        // pode modificar aqui (inicio) =========
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "ir"
        newWord.father_id = 1
        
        flexions = ["Infinitivo", "Infinitivo Flexionado - 1ª singular", "Futuro de Conjuntivo - 1ª singular", "Futuro de Conjuntivo - 3ª singular", "Infinitivo Flexionado - 3ª singular"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["verbo"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "bola"
        newWord.father_id = 2
        
        flexions = ["Singular", "Plural"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["nome feminino"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "bolo"
        newWord.father_id = 3
        
        flexions = ["Singular", "Plural"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["nome masculino"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        
        // pode modificar aqui (fim) =========
    }
    
    // Método para teste (REMOVER DEPOIS)
    func test_classify(phrase:String) -> [Word]{
        var separatedWords:[String]
        separatedWords = phrase.componentsSeparatedByString(" ")
        
        var words:[Word]
        words = []
        
        for separatedWord in separatedWords{
            for word in WordsList{
                if word.text == separatedWord{
                    words.append(word)
                }
            }
        }
        
        return words
    }
    
    func classify(var phrase:String) -> [Word]{
    
        var words_list:[Word]
        words_list = []
        
        phrase = phrase.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        let endpoint = NSURL(string: "https://projetolibrasapi.herokuapp.com/word/classify/" + phrase + "/")
        let data:NSData = NSData(contentsOfURL: endpoint!)!
        
        do {
            
            if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                if let words: NSArray = jsonResult.objectForKey("words") as? NSArray {
                    for word in words{
                        
                        var new_word:Word
                        new_word = Word.init()
                        
                        if let id: Int = word.objectForKey("id") as? Int{
                            new_word.id = id
                        }
                        
                        if let father_id: Int = word.objectForKey("word_id") as? Int{
                            new_word.father_id = father_id
                        }
                        
                        if let description: String = word.objectForKey("description") as? String{
                            new_word.text = description
                        }
                        
                        var categories_list:[Category]
                        categories_list = []
                        
                        if let categories: NSArray = word.objectForKey("categories") as? NSArray {
                            for category in categories{
                                
                                var new_category:Category
                                new_category = Category.init()
                                
                                if let id: Int = category.objectForKey("id") as? Int{
                                    new_category.id = id
                                }
                                
                                if let description: String = category.objectForKey("description") as? String{
                                    new_category.text = description
                                }
                                
                                categories_list.append(new_category)
                                
                            }
                        }
                        
                        new_word.categories = categories_list
                        
                        var flexion_list:[Flexion]
                        flexion_list = []
                        
                        if let flexions: NSArray = word.objectForKey("flexions") as? NSArray {
                            for flaxion in flexions{
                                
                                var new_flexion:Flexion
                                new_flexion = Flexion.init()
                                
                                if let id: Int = flaxion.objectForKey("id") as? Int{
                                    new_flexion.id = id
                                }
                                
                                if let description: String = flaxion.objectForKey("description") as? String{
                                    new_flexion.text = description
                                }
                                
                                flexion_list.append(new_flexion)
                            }
                        }
                        
                        new_word.flexions = flexion_list
                        
                        words_list.append(new_word)
                        
                    }
                }
            }
            
        } catch let error as NSError {
            
            print(error)
        }
        
        return words_list
    }
    
}
