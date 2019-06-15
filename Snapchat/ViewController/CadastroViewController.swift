//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 15/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController {
    
    let firebase = Database.database().reference()
    
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    @IBOutlet weak var campoConfirmaSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func exibirMensagem(titulo: String, mensagem: String) {
        let alerta = Alerta(titulo: titulo, mensagem: mensagem)
        present(alerta.getAlerta(), animated: true, completion: nil)
    }

    @IBAction func botaoCadastro(_ sender: Any) {
        if let email = campoEmail.text {
            if let nome = campoNome.text{
                if let senha = campoSenha.text {
                    if let confirmaSenha = campoConfirmaSenha.text {
                        if senha ==  confirmaSenha{
                            if nome != "" {
                                let autenticacao = Auth.auth()
                                autenticacao.createUser(withEmail: email, password: senha, completion: { (user, erro) in
                                    if erro == nil{
                                        if user == nil{
                                            self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao autenticar. Tente novamente")
                                        }else{
                                            
                                            //salvar dados no database do Firebase
                                            let database = Database.database().reference()
                                            let usuarios = database.child("usuarios")
                                            let userDados = ["nome": nome, "email": email]
                                            usuarios.child(user!.uid).setValue(userDados)
                                            //cadastro bem sucedido - seguir pra tela principal
                                            self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                        }
                                    } else {
                                        let erroR = erro! as NSError
                                        var mensagemErro = ""
                                        if let codigoErro = erroR.userInfo["error_name"] {
                                            let erroTexto = codigoErro as! String
                                            
                                            switch erroTexto {
                                            case "ERROR_INVALID_EMAIL":
                                                mensagemErro = "Email invalido"
                                                break
                                            case "ERROR_WEAK_PASSWORD":
                                                mensagemErro = "Insira uma senha com no mínimo 6 caracteres"
                                                break
                                            case "ERROR_EMAIL_ALREADY_IN_USE":
                                                mensagemErro = "Email já cadastrado"
                                                break
                                            default:
                                                mensagemErro = "Dados digitados incorretamente"
                                            }
                                            
                                        }
                                        self.exibirMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                                    }
                                })
                            }else{self.exibirMensagem(titulo: "Insira um nome", mensagem: "Preencha o campo de nome completo")}
                        } else{self.exibirMensagem(titulo: "Dados inválidos", mensagem: "As senhas não estão iguais, digite novamente.")}
                    } else{self.exibirMensagem(titulo: "Insira uma senha", mensagem: "Preencha o campo de senha")} //insira confirma senha
                } else{self.exibirMensagem(titulo: "Confirme a senha", mensagem: "Preencha o campo de confirmação da senha")} //insira senha
            } else{self.exibirMensagem(titulo: "Insira um nome", mensagem: "Preencha o campo de nome completo")} //insira nome
        } else{self.exibirMensagem(titulo: "Insira um email", mensagem: "Preencha o campo de email")} //insira email
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
