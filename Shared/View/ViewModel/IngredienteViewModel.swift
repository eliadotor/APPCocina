//
//  IngredienteViewModel.swift
//  APPCocina (iOS)
//
//  Esta clase gestiona todas las funciones de los ingredientes
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

    /* Constructor
     * Parámetro: ingrediente -> modelo de Ingrediente que inicializa todos sus atributos
     */
    init(ingrediente: Ingrediente = Ingrediente(id: 0, nombre: "", cantidad: 0, unidad: "")) {
        self.ingrediente = ingrediente
    }
    
    /* Función que añade un ingrediente a la base de datos
     * Parámetro: ref -> referencia de la receta en la que se va a añadir el ingrediente
     */
    func anadirIngrediente(ref: String) {
        ingrediente.id += 1
        do{
            try bd.collection("recetas").document(ref).collection("ingredientes").document(ingrediente.nombre).setData(from: ingrediente)
        }
        catch {
            print(error)
        }
    }
    
    /* Función que obtiene todos los ingredientes de una receta de la base de datos
     * Parámetro: ref -> referencia de la receta a la que pertenece el ingrediente
     */
    func getIngredientes(ref: String) {
        bd.collection("recetas").document(ref).collection("ingredientes").addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            DispatchQueue.main.async {
                self.ingredientes = documentos.compactMap { (queryDocumentSnapshot) -> Ingrediente? in
                    return try? queryDocumentSnapshot.data(as: Ingrediente.self)
                }
            }
        }
    }
}
