//
//  Receta.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 07/05/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Receta: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var titulo: String
    var categoria: String
    var foto: String
    var duracion: Int
    var raciones: Int
    var puntuacion: Int
    var userId: String
}

