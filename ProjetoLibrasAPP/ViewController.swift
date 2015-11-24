//
//  ViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 17/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//  
//  ESTA É A VIEW DE BASE APAR CRIAR AS OUTRAS VIEWS (COM EXCEÇÃO DA VIEW DO MENU)

import UIKit

class ViewController: UIViewController, UIBarPositioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func hideBackButton(){
        self.navigationItem.hidesBackButton = true
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    func showNavigation(){
        self.navigationController?.navigationBar.hidden = false
    }
    
    func hideNavigation(){
        self.navigationController?.navigationBar.hidden = true
    }
    
    func reachabilityStatusChanged() -> Bool {
        if reachabilityStatus == kNOTREACHABLE {
            let alertController = UIAlertController(title: "Atenção", message: "Sem conexão com a internet!", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.navigationController?.popToRootViewControllerAnimated(true)
            //self.presentViewController(alertController, animated: true, completion: nil)
            return true
        }else{
            return false
        }
    }
}
