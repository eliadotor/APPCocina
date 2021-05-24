//
//  CodigoQR.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import Foundation

struct CodigoQR: Identifiable, Codable {
    var id: String = UUID().uuidString
    var imagenURL: String
    var descripcion: String
    var fecha: Date
    var caducidad: Date
    var userId: String
}
