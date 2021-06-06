//
//  Usuario.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 6/6/21.
//

import Foundation

struct Usuario: Identifiable, Codable {
    var id: String
    var nombre: String
    var nick: String
    var correo: String
    var foto: String
}
