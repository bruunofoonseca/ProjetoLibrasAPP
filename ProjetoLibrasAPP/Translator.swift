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
        newWord.text = "poder"
        newWord.motto = "poder"
        newWord.id = 6
        
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
        newWord.text = "gostar"
        newWord.motto = "gostar"
        newWord.id = 1
        
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
        newWord.text = "derramar"
        newWord.motto = "derramar"
        newWord.id = 1
        
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
        newWord.text = "estacionar"
        newWord.motto = "estacionar"
        newWord.id = 1
        
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
        newWord.text = "estudar"
        newWord.motto = "estudar"
        newWord.id = 1
        
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
        newWord.text = "coçar"
        newWord.motto = "coçar"
        newWord.id = 1
        
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
        newWord.text = "ir"
        newWord.motto = "ir"
        newWord.id = 1
        
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
        newWord.text = "pensar"
        newWord.motto = "pensar"
        newWord.id = 1
        
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
        newWord.text = "ter"
        newWord.motto = "ter"
        newWord.id = 1
        
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
        newWord.text = "trabalho"
        newWord.motto = "trabalho"
        newWord.id = 2
        
        flexions = ["singular"]
        
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
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "meninos"
        newWord.motto = "meninos"
        newWord.id = 2
        
        flexions = ["plural"]
        
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
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "menina"
        newWord.motto = "menina"
        newWord.id = 2
        
        flexions = ["singular"]
        
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
        newWord.text = "mercado"
        newWord.motto = "mercado"
        newWord.id = 2
        
        flexions = ["singular"]
        
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
        
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "casa"
        newWord.motto = "casa"
        newWord.id = 3
        
        flexions = ["singular"]
        
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
        newWord.text = "casas"
        newWord.motto = "casas"
        newWord.id = 3
        
        flexions = ["plural"]
        
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
        newWord.text = "festa"
        newWord.motto = "festa"
        newWord.id = 3
        
        flexions = ["singular"]
        
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
        newWord.text = "senhor"
        newWord.motto = "senhor"
        newWord.id = 3
        
        flexions = ["Masculino singular"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["pronome"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "eu"
        newWord.motto = "eu"
        newWord.id = 3
        
        flexions = ["Feminino singular", "Masculino singular","Feminino plural", "Masculino plural"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["pronome"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "você"
        newWord.motto = "você"
        newWord.id = 3
        
        flexions = ["Feminino singular", "Masculino singular","Feminino plural", "Masculino plural"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["pronome"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "ele"
        newWord.motto = "ele"
        newWord.id = 3
        
        flexions = ["Feminino singular", "Masculino singular","Feminino plural", "Masculino plural"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["pronome"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "nós"
        newWord.motto = "nós"
        newWord.id = 3
        
        flexions = ["Feminino singular", "Masculino singular","Feminino plural", "Masculino plural"]
        
        for flexion in flexions{
            newFlexion = Flexion.init()
            newFlexion.text = flexion
            newWord.flexions.append(newFlexion)
        }
        
        categories = ["pronome"]
        
        for category in categories{
            newCategory = Category.init()
            newCategory.text = category
            newWord.categories.append(newCategory)
        }
        
        WordsList.append(newWord)
        // BLOCO FIM ====================
        
        // BLOCO ====================
        newWord = Word.init()
        newWord.text = "jogo"
        newWord.motto = "jogo"
        newWord.id = 3
        
        flexions = ["singular"]
        
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
                
        for word in words
        {
            print(word.text)
        }

        return words
    }
    
    func classify(var phrase:String) -> [Word]{
    
        var words_list:[Word]
        words_list = []
        
        phrase = phrase.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        let endpoint = NSURL(string: "http://172.16.1.41:3000/word/classify/true/" + phrase + "/")
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
                        
                        if let motto: AnyObject = word.objectForKey("motto"){
                            new_word.motto = motto.objectForKey("description") as? String
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
    
    func get_verbs(motto:String, flexion:String) -> String{
        
        var words_list:[Word]
        words_list = []
        
        var params:String = motto.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        params = params + "--" + flexion.stringByReplacingOccurrencesOfString(" ", withString: "%20")

        let endpoint = NSURL(string: "http://172.16.1.41:3000/word/verbs/true/" + params + "/")
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
                        
                        if let motto: AnyObject = word.objectForKey("motto"){
                            new_word.motto = motto.objectForKey("description") as? String
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
        
        return words_list[0].text
    }
    
    func get_nouns(motto:String, flexion:String) -> String{
        
        var words_list:[Word]
        words_list = []
        
        var params:String = motto.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        params = params + "--" + flexion.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        let endpoint = NSURL(string: "http://172.16.1.41:3000/word/nouns/true/" + params + "/")
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
                        
                        if let motto: AnyObject = word.objectForKey("motto"){
                            new_word.motto = motto.objectForKey("description") as? String
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
        
        return words_list[0].text
    }
    
    func get_adjectives(motto:String, flexion:String) -> String{
        
        var words_list:[Word]
        words_list = []
        
        var params:String = motto.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        params = params + "--" + flexion.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        let endpoint = NSURL(string: "http://172.16.1.41:3000/word/adjectives/true/" + params + "/")
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
                        
                        if let motto: AnyObject = word.objectForKey("motto"){
                            new_word.motto = motto.objectForKey("description") as? String
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
        
        return words_list[0].text
    }
    
    func buscaVerbo(verbo: String, sujeito: String, flexao: String, categoria: String) -> String
    {
        var ab : String!
        let sujeito = sujeito.lowercaseString
        if (verbo == "poder"){
            if (sujeito == "eu"){
                ab = "posso"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "pode"
            }
            else if (sujeito == "nós"){
                ab = "podemos"
            }
            else if (sujeito == "eles") || (flexao == "plural"){
                ab = "podem"
            }
        }
        else if (verbo == "gostar"){
            if (sujeito == "eu"){
                ab = "gosto"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "gosta"
            }
            else if (sujeito == "nós"){
                ab = "gostamos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "gostam"
            }
        }
        else if (verbo == "ir"){
            if (sujeito == "eu"){
                ab = "vou"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular") || (flexao == "Masculino singular")) {
                ab = "vai"
            }
            else if (sujeito == "nós"){
                ab = "vamos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "vão"
            }
        }
        else if (verbo == "ter"){
            if (sujeito == "eu"){
                ab = "tenho"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "tem"
            }
            else if (sujeito == "nós"){
                ab = "temos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "têm"
            }
        }
        else if (verbo == "estudar"){
            if (sujeito == "eu"){
                ab = "estudo"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "estuda"
            }
            else if (sujeito == "nós"){
                ab = "estudamos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "estudam"
            }
        }
        else if (verbo == "pensar"){
            if (sujeito == "eu"){
                ab = "penso"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "pensa"
            }
            else if (sujeito == "nós"){
                ab = "pensamos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "pensam"
            }
        }
        else if (verbo == "estacionar"){
            if (sujeito == "eu"){
                ab = "estaciono"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "estaciona"
            }
            else if (sujeito == "nós"){
                ab = "estaciomamos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "estacionam"
            }
        }
        else if (verbo == "derramar"){
            if (sujeito == "eu"){
                ab = "derramo"
            }
            else if ((sujeito == "você") || (sujeito == "ele") || (sujeito == "ela") || (flexao == "singular")) {
                ab = "derrama"
            }
            else if (sujeito == "nós"){
                ab = "derramamos"
            }
            else if (sujeito == "eles") || (flexao == "plural") {
                ab = "derramam"
            }
        }
        else{
            ab = verbo
        }
        return ab
    }
    
    func buscaAdjetivo(adjetivo: String, flexao: String) -> String
    {
        let ab = "Lindu"
        return ab
    }
}
