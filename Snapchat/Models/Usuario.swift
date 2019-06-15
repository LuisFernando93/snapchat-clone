//
//  Usuario.swift
//  Snapchat
//
//  Created by Luis Fernando Pasquinelli Amaral de Abreu on 30/03/2018.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Usuario {
    
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
