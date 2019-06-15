//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 15/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class EntrarViewController: UIViewController {

    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func exibirMensagem(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func botaoLogin(_ sender: Any) {
        if let email = campoEmail.text {
            if let senha = campoSenha.text{
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: email, password: senha, completion: { (user, erro) in
                    
                    if erro == nil{
                        if user == nil{
                            self.exibirMensagem(titulo: "Dados inválidos", mensagem: "Problema ao autenticar. Tente novamente")
                        }else{
                            //login bem sucedido - seguir pra tela principal
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                        
                    }else{
                        self.exibirMensagem(titulo: "Dados incorretos", mensagem: "Verifique os dados e tente novamente")
                    }
                    
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
