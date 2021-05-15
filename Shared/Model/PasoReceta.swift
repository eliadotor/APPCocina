//
//  PasoReceta.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 13/05/2021.
//

import Foundation

struct Paso: Identifiable, Codable {
    var id: Int
    var descripcion: String
    var duracion: Int
}
