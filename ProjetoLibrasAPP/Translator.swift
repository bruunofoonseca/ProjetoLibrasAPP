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
        
        WordsList = []
    }
    
    func classify(phrase:String) -> [Word]{
        
        do {
            
            var words_list:[Word]
            words_list = []
            
            let aux = "https://libiapi.herokuapp.com/word/classify_words/true/" + phrase + "/"
            let endpoint = NSURL(string: aux.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
            let data:NSData = NSData(contentsOfURL: endpoint!)!
            
            if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                if let words: [NSDictionary] = jsonResult.objectForKey("words") as? [NSDictionary] {
                    for word:NSDictionary in words{
                        
                        var new_word:Word
                        new_word = Word.init()
                        
                        if let id: Int = word.objectForKey("id") as? Int{
                            new_word.id = id
                        }
                        
                        if let description: String = word.objectForKey("description") as? String{
                            new_word.text = description
                        }
                        
                        // Pega mottos =======
                        
                        var motto_list:[Motto]
                        motto_list = []
                        
                        if let mottos: NSArray = word.objectForKey("mottos") as? NSArray {
                            for motto in mottos{
                                
                                var new_motto:Motto
                                new_motto = Motto.init()
                                
                                if let description: String = motto.objectForKey("description") as? String{
                                    new_motto.text = description
                                }
                                
                                var categories_list:[Category]
                                categories_list = []
                                
                                if let categories: NSArray = motto.objectForKey("categories") as? NSArray {
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
                                
                                new_motto.categories = categories_list
                                
                                motto_list.append(new_motto)
                            }
                        }
                        
                        new_word.mottos = motto_list
                        
                        // Pega flexions =======
                        
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
                        
                        
                        // Adiciona na lista de palavras
                        
                        words_list.append(new_word)
                        
                    }
                }
            }
            
            return words_list
            
        } catch let error as NSError {
            
            debugPrint(error)
            
            return []
        }
    }
    
    func get_verbs(motto:String, flexion:String) -> String{
        
        do {
            
            var words_list:[Word]
            words_list = []
            
            var params:String = motto
            params = params + "/" + flexion
            
            let endpoint = "https://libiapi.herokuapp.com/word/classify_verbs/true/" + params + "/"
            let url = endpoint.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let data:NSData = NSData(contentsOfURL: NSURL(string: url!)!)!
            
            if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                if let words: [NSDictionary] = jsonResult.objectForKey("words") as? [NSDictionary] {
                    for word:NSDictionary in words{
                        
                        var new_word:Word
                        new_word = Word.init()
                        
                        if let id: Int = word.objectForKey("id") as? Int{
                            new_word.id = id
                        }
                        
                        if let description: String = word.objectForKey("description") as? String{
                            new_word.text = description
                        }
                        
                        // Pega mottos =======
                        
                        var motto_list:[Motto]
                        motto_list = []
                        
                        if let mottos: NSArray = word.objectForKey("mottos") as? NSArray {
                            for motto in mottos{
                                
                                var new_motto:Motto
                                new_motto = Motto.init()
                                
                                if let description: String = motto.objectForKey("description") as? String{
                                    new_motto.text = description
                                }
                                
                                var categories_list:[Category]
                                categories_list = []
                                
                                if let categories: NSArray = motto.objectForKey("categories") as? NSArray {
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
                                
                                new_motto.categories = categories_list
                                
                                motto_list.append(new_motto)
                            }
                        }
                        
                        new_word.mottos = motto_list
                        
                        // Pega flexions =======
                        
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
                        
                        
                        // Adiciona na lista de palavras
                        
                        words_list.append(new_word)
                        
                    }
                }
            }
            
            return words_list[0].text
            
        } catch let error as NSError {
            
            debugPrint(error)
            
            return motto
        }
    }
    
    func get_adjectives(motto:String, flexion:String) -> String{
        
        do {
            
            var words_list:[Word]
            words_list = []
            
            var params:String = motto
            params = params + "/" + flexion
            
            let endpoint = "https://libiapi.herokuapp.com/word/classify_adjectives/true/" + params + "/"
            let url = endpoint.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let data:NSData = NSData(contentsOfURL: NSURL(string: url!)!)!
            
            if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                if let words: [NSDictionary] = jsonResult.objectForKey("words") as? [NSDictionary] {
                    for word:NSDictionary in words{
                        
                        var new_word:Word
                        new_word = Word.init()
                        
                        if let id: Int = word.objectForKey("id") as? Int{
                            new_word.id = id
                        }
                        
                        if let description: String = word.objectForKey("description") as? String{
                            new_word.text = description
                        }
                        
                        // Pega mottos =======
                        
                        var motto_list:[Motto]
                        motto_list = []
                        
                        if let mottos: NSArray = word.objectForKey("mottos") as? NSArray {
                            for motto in mottos{
                                
                                var new_motto:Motto
                                new_motto = Motto.init()
                                
                                if let description: String = motto.objectForKey("description") as? String{
                                    new_motto.text = description
                                }
                                
                                var categories_list:[Category]
                                categories_list = []
                                
                                if let categories: NSArray = motto.objectForKey("categories") as? NSArray {
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
                                
                                new_motto.categories = categories_list
                                
                                motto_list.append(new_motto)
                            }
                        }
                        
                        new_word.mottos = motto_list
                        
                        // Pega flexions =======
                        
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
                        
                        
                        // Adiciona na lista de palavras
                        
                        words_list.append(new_word)
                        
                    }
                }
            }
            
            if (WordsList.count > 0){
                return words_list[0].text
            }else{
                return ""
            }
            
        } catch let error as NSError {
            
            debugPrint(error)
            
            return motto
        }
    }
}
