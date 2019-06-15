//
//  Alerta.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 23/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class Alerta{
    
    var titulo: String
    var mensagem: String
    
    init(titulo: String, mensagem: String) {
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func getAlerta() -> UIAlertController {
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction(acaoCancelar)
        return alerta
    }
}
