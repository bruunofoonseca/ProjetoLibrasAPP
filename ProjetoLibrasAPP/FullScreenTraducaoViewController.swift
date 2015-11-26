//
//  FullScreenTraducaoViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 23/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import AVFoundation

class FullScreenTraducaoViewController: ViewController {

    @IBOutlet weak var fraseLabel: UILabel!
    var frase : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fraseLabel.text = frase
        falarFrase()
        
        super.showNavigation()
        
        self.view.makeToast(message: "Falando frase")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
    
    func falarFrase(){
        let synt: AVSpeechSynthesizer = AVSpeechSynthesizer()
        
        let nextSpeach:AVSpeechUtterance = AVSpeechUtterance(string: frase)
        nextSpeach.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        
        let os = NSProcessInfo().operatingSystemVersion
        switch (os.majorVersion){
        case 8:
            nextSpeach.rate = 0
            break
        default:
            nextSpeach.rate = 0.42
            break
        }
        
        synt.speakUtterance(nextSpeach)
    }
    
    
    @IBAction func falar(sender: AnyObject) {
       self.view.makeToast(message: "Falando frase")
        falarFrase()
    }

}
