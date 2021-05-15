//
//  IngredienteViewModel.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 11/05/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class IngredienteViewModel: ObservableObject {

    private var bd = Firestore.firestore()

    @Published var ingredientes: [Ingrediente] = []
    @Published var ingrediente : Ingrediente
    
    init(ingrediente: Ingrediente = Ingrediente(nombre: "", cantidad: 0, unidad: 0)) {
        self.ingrediente = ingrediente
    }
    
    func anadirIngrediente(ref: String) {
        do{
            try bd.collection("recetas").document(ref).collection("ingredientes").document(ingrediente.nombre).setData(from: ingrediente)
        }
        catch {
            print(error)
        }
    }
}
