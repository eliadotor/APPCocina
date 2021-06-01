//
//  CodigoQR.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct CodigoQR: Identifiable, Codable {
    var id: String
    var imagenURL: String
    var titulo: String
    var descripcion: String
    var fecha: Date
    var caducidad: Date
    var userId: String
}
