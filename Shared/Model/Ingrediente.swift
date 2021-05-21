//
//  Ingrediente.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 13/05/2021.
//

import Foundation

struct Ingrediente: Identifiable, Codable {
    var id: Int
    var nombre: String
    var cantidad: Int
    var unidad: String
}
