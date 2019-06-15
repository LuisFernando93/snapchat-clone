//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 31/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var contador: UILabel!
    
    var snap = Snap()
    var tempo = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descricao.text = "Carregando..."
        
        let url = URL(string: snap.urlImagem)
        imagem.sd_setImage(with: url) { (imagem, erro, cache, url) in
            
            if erro == nil{
                self.descricao.text = self.snap.descricao
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    //decrementar timer
                    self.tempo = self.tempo - 1
                    //exibir timer
                    self.contador.text = String(self.tempo)
                    
                    //caso o tempo execute ate zero, invalida
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            //Remove no do database
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            snaps.child(snap.identificador).removeValue()
            
            //Remove imagem do storage
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            
            imagens.child("\(snap.idImagem).jpg").delete { (erro) in
                if erro == nil{
                    print("sucesso ao apagar")
                }else{
                    print("erro ao apagar")
                }
            }
            
        }
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
