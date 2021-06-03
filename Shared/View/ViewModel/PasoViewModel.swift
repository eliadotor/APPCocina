//
//  PasoViewModel.swift
//  APPCocina (iOS)
//
//  Esta clase gestiona todas las funciones de los pasos de las recetas
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
    
    /* Constructor
     * Parámetro: paso -> modelo de Paso que inicializa todos sus atributos
     */
    init(paso: Paso = Paso(id: 0, descripcion: "", duracion: 1)) {
        self.paso = paso
    }
    
    /* Función que añade un paso a la base de datos
     * Parámetro: ref -> referencia de la receta en la que se va a añadir el paso
     */
    func anadirPaso(ref: String) {
        paso.id += 1
        do{
            try bd.collection("recetas").document(ref).collection("pasos").document("Paso \(paso.id)").setData(from: paso)
        }
        catch {
            print(error)
        }
    }
    
    /* Función que obtiene todos los pasos de una receta de la base de datos
     * Parámetro: ref -> referencia de la receta de la que se van a obtener los pasos
     */
    func getPasos(ref: String) {
        bd.collection("recetas").document(ref).collection("pasos").addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            DispatchQueue.main.async {
                self.pasos = documentos.compactMap { (queryDocumentSnapshot) -> Paso? in
                    return try? queryDocumentSnapshot.data(as: Paso.self)
                }
            }
        }
    }
    
    /* Función que obtiene un paso de una receta de la base de datos
     * Parámetro: ref -> referencia de la receta
     * id -> id del paso que se va a obtener
     */
    func getPaso(ref: String, id: Int) {
        bd.collection("recetas").document(ref).collection("pasos").document("Paso \(id)").getDocument { (document, error) in
            if let document = document, document.exists {
                let pasoDescripcion = document.data().map(String.init(describing:)) ?? "nil"
                print(pasoDescripcion)
            } else {
                print("El paso no existe")
            }
            DispatchQueue.main.async {
                self.paso = document.map { queryDocumentSnapshot -> Paso in
                    let data = queryDocumentSnapshot.data()
                    let id = data?["id"] as? Int ?? 0
                    let descripcion = data?["descripcion"] as? String ?? ""
                    let duracion = data?["duracion"] as? Int ?? 0

                    return Paso(id: id, descripcion: descripcion, duracion: duracion)
                }!
            }
        }
    }
}
