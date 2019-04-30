//
//  Snap.swift
//  Snapchat
//
//  Created by Eduardo on 30/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import Foundation

class Snap {
    var identificador: String
    var nome: String
    var de: String
    var descricao: String
    var urlImagem: String
    var idImagem: String
    
    init(identificador: String, nome: String, de: String, desc: String, urlImage: String, idImagem: String) {
        self.identificador = identificador
        self.nome = nome
        self.de = de
        self.descricao = desc
        self.urlImagem = urlImage
        self.idImagem = idImagem
    }
}
