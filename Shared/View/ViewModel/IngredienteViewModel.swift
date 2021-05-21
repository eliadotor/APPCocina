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
    
    @Published var medidas: Array = ["gramos", "kilogramos", "litros", "mililitros", "cucharada", "taza", "puñado", "pellizco"]

    
    init(ingrediente: Ingrediente = Ingrediente(id: 0, nombre: "", cantidad: 0, unidad: "")) {
        self.ingrediente = ingrediente
    }
    
    func anadirIngrediente(ref: String) {
        ingrediente.id += 1
        do{
            try bd.collection("recetas").document(ref).collection("ingredientes").document(ingrediente.nombre).setData(from: ingrediente)
        }
        catch {
            print(error)
        }
    }
    
    func getIngredientes(ref: String) {
        bd.collection("recetas").document(ref).collection("ingredientes").addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.ingredientes = documentos.compactMap { (queryDocumentSnapshot) -> Ingrediente? in
                return try? queryDocumentSnapshot.data(as: Ingrediente.self)
            }
        }
    }
}
