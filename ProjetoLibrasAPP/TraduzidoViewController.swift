//
//  TraduzidoViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 23/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class TraduzidoViewController: ViewController {

    @IBOutlet weak var fraseUsuarioLabel: UILabel!
    @IBOutlet weak var fraseTraduzidaLabel: UILabel!
    @IBOutlet weak var tempoVerbalControl: UISegmentedControl!
    
    var frases : [[String]] = []
    var fraseTraduzida : [String] = []
    var fraseUsuario = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fraseUsuarioLabel.text = fraseUsuario
        selecionaFrase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
    
    /* Muda o tempo verbal da frase */
    
    func selecionaFrase(){
        let index = tempoVerbalControl.selectedSegmentIndex
        
        fraseTraduzidaLabel.text = fraseTraduzida[index]
    }
    
    @IBAction func mudaTempoVerbal(sender: UISegmentedControl) {
        selecionaFrase()
    }
    
    /* Mostra em tela cheia */
    
    @IBAction func showFullScreen(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowFullScreenTradutor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ShowFullScreenTradutor" {
            
            let svc = segue.destinationViewController as! FullScreenTraducaoViewController
            
            svc.frase = fraseTraduzidaLabel.text!
        }
    }
}
