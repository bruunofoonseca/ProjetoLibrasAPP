//
//  HomeViewController.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 10/19/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var signWritingTraducao: UIImageView!
    @IBOutlet weak var signWritingPesquisar: UIImageView!
    @IBOutlet weak var signWritingExplicacao: UIImageView!
    @IBOutlet weak var btnTraducao: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func voltarHome(segue:UIStoryboardSegue){
       
    }
    
    @IBAction func btnTraducaoAction(sender: AnyObject) {
        signWritingTraducao.alpha = 0.5
    }
    
    @IBAction func btnTraducaoActionUp(sender: AnyObject) {
        signWritingTraducao.alpha = 1.0
    }
    
    @IBAction func btnTraducaoActionDrag(sender: AnyObject) {
        signWritingTraducao.alpha = 1.0
    }
    
    @IBAction func btnPesquisarAction(sender: AnyObject) {
        signWritingPesquisar.alpha = 0.5
    }
    
    @IBAction func btnPesquisarActionUp(sender: AnyObject) {
        signWritingPesquisar.alpha = 1.0
    }
    
    @IBAction func btnPesquisarActionDrag(sender: AnyObject) {
        signWritingPesquisar.alpha = 1.0
    }
    
    @IBAction func btnExplicacaoAction(sender: AnyObject) {
        signWritingExplicacao.alpha = 0.5
    }
    
    @IBAction func btnExplicacaoActionUp(sender: AnyObject) {
        signWritingExplicacao.alpha = 1.0
    }
    
    @IBAction func btnExplicacaoActionDrag(sender: AnyObject) {
        signWritingExplicacao.alpha = 1.0
    }
    
    
}
