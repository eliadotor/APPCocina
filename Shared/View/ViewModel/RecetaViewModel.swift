//
//  RecetaViewModel.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 11/05/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import FirebaseAuth


class RecetaViewModel: ObservableObject {
    
    private var bd = Firestore.firestore()
    
    @Published var nuevaRecetaRef: DocumentReference? = nil
    @Published var recetas: Array = [Receta]()
    @Published var receta: Receta
    
    
    @Published var categorias: Array = ["desayuno", "comida", "cena", "snacks"]
    

    init(receta: Receta = Receta(id:"", titulo: "", categoria: "", foto: "", duracion: 0, raciones: 0, puntuacion: 0, userId: "")) {
        self.receta = receta
    }
     
    
    func anadirRecetas() -> String{
        do {
            nuevaRecetaRef = try bd.collection("recetas").addDocument(from: receta)
        }
        catch {
            print(error)
        }
        return nuevaRecetaRef!.documentID
    }
    
    func getRecetas() {
        bd.collection("recetas").addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.recetas = documentos.compactMap { (queryDocumentSnapshot) -> Receta? in
                return try? queryDocumentSnapshot.data(as: Receta.self)
            }
        }
    }
    
}
