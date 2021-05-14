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


class RecetassViewModel: ObservableObject {
    
    private var bd = Firestore.firestore()
    
    @Published var nuevaRecetaRef: DocumentReference? = nil
    @Published var recetas: Array = [Receta]()
    @Published var receta: Receta
    
    
    @Published var categorias: Array = ["desayuno", "comida", "cena", "snacks"]
    

    init(receta: Receta = Receta(id:"", titulo: "", categoria: "", foto: "", duracion: 0, raciones: 0, userId: "")) {
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
    
    
}
