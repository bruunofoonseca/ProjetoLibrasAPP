//
//  MenuViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 17/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var btnTraducao: UIButton!
    
    var internetObject = InternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observerInternet()
        hideNavigation()
        
        if !checkFirstTimeEver(){
            checkFirstTimeOpen()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        internetObject.verifyInternetStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        hideNavigation()
    }
    
    @IBAction func showTraducao(sender: AnyObject) {
        performSegueWithIdentifier("ShowTradutor", sender: self)
    }
    
    @IBAction func showPesquisa(sender: AnyObject) {
        performSegueWithIdentifier("ShowFrases", sender: self)
    }
    
    @IBAction func showExplicacao(sender: AnyObject) {
        performSegueWithIdentifier("ShowVideos", sender: self)
    }
    
    func hideNavigation(){
        self.navigationController?.navigationBar.hidden = true
    }
    
    /* Adiciona observer para verificar a internet */
    
    func observerInternet(){
        NSNotificationCenter.defaultCenter().addObserver(internetObject, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
    }
    
    /* Verifica a mudança de estado da internet e emite o alert */
    
    func reachabilityStatusChanged() {
        if reachabilityStatus == kNOTREACHABLE {
            let alertController = UIAlertController(title: "Atenção", message: "Sem conexão com a internet!", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    /* Verifica se é a primeira vez abrindo o app do inicio */
    
    func checkFirstTimeOpen(){
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") == false){
            // This is the first launch ever
            performSegueWithIdentifier("ShowFirst", sender: self)
        }
    }
    
    /* Verifica se é a primeira vez usando o app após instalado */

    func checkFirstTimeEver() -> Bool{
        let hasLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if !hasLaunch  {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            performSegueWithIdentifier("ShowFirstTutorial", sender: self)
            return true
        }else{
            return false
        }
    }
}
