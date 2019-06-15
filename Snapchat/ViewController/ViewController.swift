//
//  ViewController.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 15/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let autenticacao = Auth.auth()
        
        /*do {
            try autenticacao.signOut()
        } catch {
            print("erro ao deslogar usuario")
        }*/
        
        autenticacao.addStateDidChangeListener { (autenticacao, user) in
            if let usuarioLogado = user {
                self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

