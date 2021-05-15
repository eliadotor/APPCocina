//
//  PasoViewModel.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 11/05/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PasoViewModel: ObservableObject {
    private var bd = Firestore.firestore()

    @Published var pasos: Array = [Paso]()
    @Published var paso: Paso
    
    init(paso: Paso = Paso(id: 0, descripcion: "", duracion: 1)) {
        self.paso = paso
    }
    
    func anadirPaso(ref: String){
        paso.id += 1
        do{
            try bd.collection("recetas").document(ref).collection("pasos").document("Paso \(paso.id)").setData(from: paso)
        }
        catch {
            print(error)
        }
    }
    
    func getPasos(ref: String) {
        bd.collection("recetas").document(ref).collection("pasos").addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.pasos = documentos.compactMap { (queryDocumentSnapshot) -> Paso? in
                return try? queryDocumentSnapshot.data(as: Paso.self)
            }
        }
    }
}
