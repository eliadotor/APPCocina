//
//  Receta.swift
//  cocina
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
    //var pasos = Set<Pasos>()
    //var ingredientes = Set <Ingrediente>()

}

struct Pasos: Identifiable {
    var id = UUID()
    var paso : String
}

struct Ingrediente: Identifiable {
    var id = UUID()
    var nombre : String
}
