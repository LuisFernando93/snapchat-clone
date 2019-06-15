//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 22/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var campoDescricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    var idImagem = NSUUID().uuidString
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
    }
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        //recuperar imagem
        if let imagemSelecionada = foto.image {
            if let imagemDados = UIImageJPEGRepresentation(imagemSelecionada, 0.1) {
                imagens.child("\(self.idImagem).jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                    
                    if erro == nil {
                        print("Sucesso ao fazer upload")
                        let url = metaDados?.downloadURL()?.absoluteString
                        self.performSegue(withIdentifier: "selecionarUsuarioSegue", sender: url)
                        
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    }else{
                        print("Erro ao fazer upload")
                        let alerta = Alerta(titulo: "Upload falhou", mensagem: "Erro ao salvar o arquivo. Tente novamente")
                        self.present(alerta.getAlerta(), animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selecionarUsuarioSegue" {
            let usuarioViewController = segue.destination as! UsuariosTableViewController
            usuarioViewController.descricao = self.campoDescricao.text!
            usuarioViewController.urlImagem = sender as! String
            usuarioViewController.idImagem = self.idImagem
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
        foto.image = imagemRecuperada
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor(displayP3Red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        imagePicker.dismiss(animated: true, completion: nil)
        
        
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
