//
//  RecetaViewModel.swift
//  APPCocina (iOS)
//
//  Esta clase gestiona todas las funciones de las recetas
//
//  Created by Elia Dotor Puente on 11/05/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

let imagenUrl = "gs://appcocina-5d597.appspot.com/recetas/cocina.jpg"
class RecetaViewModel: ObservableObject {
    
    private var bd = Firestore.firestore()
    
    @Published var nuevaRecetaRef: DocumentReference? = nil
    @Published var recetas: Array = [Receta]()
    @Published var receta: Receta
    
    @Published var categorias: Array = ["desayuno", "comida", "cena", "snacks"]
    
    // Alertas
    @Published var alert = false
    @Published var alertMensaje = ""
    
    /* Constructor
     * Parámetro: receta -> modelo de Receta que inicializa todos sus atributos
     */
    init(receta: Receta = Receta(id:"", titulo: "", categoria: "", foto: imagenUrl, duracion: 0, raciones: 0, puntuacion: 0, userId: Auth.auth().currentUser!.uid)) {
        self.receta = receta
    }
    
    /* Función que añade una receta a la base de datos */
    func anadirRecetas() -> String{
        do {
            nuevaRecetaRef = try bd.collection("recetas").addDocument(from: receta)
        }
        catch {
            print(error)
        }
        return nuevaRecetaRef!.documentID
    }
    
    /* Función que obtiene todas las recetas de la base de datos */
    func getRecetas() {
        bd.collection("recetas").addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            DispatchQueue.main.async {
                self.recetas = documentos.compactMap { (queryDocumentSnapshot) -> Receta? in
                    return try? queryDocumentSnapshot.data(as: Receta.self)
                }
            }
        }
    }
    
    /* Función que obtiene todas las recetas de un usuario de la base de datos */
    func getMisRecetas() {
        bd.collection("recetas").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                print("No documents")
                return
            }
            DispatchQueue.main.async {
                self.recetas = documentos.compactMap { (queryDocumentSnapshot) -> Receta? in
                    return try? queryDocumentSnapshot.data(as: Receta.self)
                }
            }
        }
    }
    
    /* Función que obtiene una receta de la base de datos
     * Parámetro: ref -> referencia de la receta
     */
    func getReceta(ref: String) {
        bd.collection("recetas").document(ref).getDocument { (document, error) in
            if let document = document, document.exists {
                let recetaDescripcion = document.data().map(String.init(describing:)) ?? "nil"
                print("Receta ref: \(recetaDescripcion)")
            } else {
                print("La receta no existe")
            }
            DispatchQueue.main.async {
                self.receta = document.map { queryDocumentSnapshot -> Receta in
                    let data = queryDocumentSnapshot.data()
                    let  id = document?.documentID
                    let titulo = data?["titulo"] as? String ?? ""
                    let categoria = data?["categoria"] as? String ?? ""
                    let foto = data?["foto"] as? String ?? ""
                    let duracion = data?["duracion"] as? Int ?? 0
                    let raciones = data?["raciones"] as? Int ?? 0
                    let puntuacion = data?["puntuacion"] as? Int ?? 0
                    let userID = data?["userId"] as? String ?? ""

                    return Receta(id: id!, titulo: titulo, categoria: categoria, foto: foto, duracion: duracion, raciones: raciones, puntuacion: puntuacion, userId: userID)
                }!
            }
        }
    }
    
    /* Función que elimina una receta de la base de datos
     * Parámetro: id -> id de la receta que se va a eliminar
     */
    func eliminar(id: String) {
        bd.collection("recetas").document(id).delete() { (error) in
            if let error = error {
                print("Error al eliminar", error.localizedDescription)
                self.alertMensaje = "Error al eliminar la receta"
                self.alert.toggle()
            } else {
                print("Elimino")
            }
        }
    }
    
}
