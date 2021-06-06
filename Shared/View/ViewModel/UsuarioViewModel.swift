//
//  UsuarioViewModel.swift
//  APPCocina (iOS)
//
//  Clase para gestionar los usuarios
//
//  Created by Elia Dotor Puente on 6/6/21.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
/*
let imageUrl = "gs://appcocina-5d597.appspot.com/usuarios/usuario.png"
class UsuarioViewModel: ObservableObject {
    private var bd = Firestore.firestore()
    let storage = Storage.storage()


    @Published var usuarios: Array = [Usuario]()
    @Published var usuario: Usuario
    
    @Published var campos: [String:Any] = [:]

    @Published var id = ""
    @Published var nuevoUsuarioRef: DocumentReference? = nil
        
    // Alertas
    @Published var alert = false
    @Published var alertMensaje = ""
    
    
    /* Constructor
     * Parámetro: usuario -> modelo de Usuario que inicializa todos sus atributos
     */
    init(usuario: Usuario = Usuario(nombre: "", nick: "", correo: "", foto: imageUrl)){
        self.usuario = usuario
    }

     /* Función que guarda la imagen en la base de datos
      * Parámetro: imagen -> imagen del usuario que se va a guardar
      * ref -> ref del usuario en el que se va a guardar la url de la imagen
     
     func guardarImgCodigo(imagen: UIImage, ref: String) {
         let storageRef = self.storage.reference()
         let nombreImagen = UUID()
         let directorio = storageRef.child("usuarios/\(nombreImagen)")
         let imagenData = imagen.jpegData(compressionQuality: 0.4)!
         let metadata = StorageMetadata()
         metadata.contentType = "image/jpg"
         directorio.putData(imagenData, metadata: metadata) { (data, error) in
             if error == nil {
                 print("Guardo imagen")
                 self.usuario.foto = String(describing: directorio)
                 self.bd.collection("usuarios").document(ref).updateData(["foto" : self.usuario.foto]) { (error) in
                     if let error = error {
                         print("Error al editar", error.localizedDescription)
                         self.alertMensaje = "Error al guardar el códigoQR"
                         self.alert.toggle()
                     } else {
                         print("Foto añadida")
                     }
                 }
             } else {
                 if let error = error?.localizedDescription {
                     print("Error en firebase al cargar imagen", error)
                 } else {
                     print("Error en imagenes")
                     self.alertMensaje = "Se ha producido un error, intentelo más tarde"
                     self.alert.toggle()
                 }
             }
         }
     } */

     /* Función que añade un usuario a la base de datos e inmediatamente lo
        modifica para añadirle el id del documento generado en la base de datos */
     func anadirUsuario() {
         do {
             nuevoUsuarioRef = try bd.collection("usuarios").addDocument(from: usuario)
         }
         catch {
             print(error)
         }
         return
     }

     /* Función que modifica un usuario en la base de datos
      * Parámetro: id -> id del usuario que se va a modificar
      */
     func modificarUsuario(id: String){
         self.campos = [
             "nombre" : usuario.nombre,
             "nick" : usuario.nick,
             "correo" : usuario.correo,
             //"password" : usuario.password,
             "foto" : usuario.foto
         ]
         bd.collection("usuarios").document(id).updateData(campos) { (error) in
             if let error = error {
                 print("Error al editar", error.localizedDescription)
                 self.alertMensaje = "Error al modificar el usuario"
                 self.alert.toggle()
             } else {
                 print("Edito")
             }
         }
        
     }
     
     /* Función que obtiene todos los usuarios de la base de datos */
     func getUsuarios() {
         bd.collection("usuarios").addSnapshotListener { (querySnapshot, error) in
             guard let documentos = querySnapshot?.documents else {
                 self.alertMensaje = "Se ha producido un error al cargar los códigos"
                 self.alert.toggle()
                 print("No documents")
                 return
             }
             DispatchQueue.main.async {
                 self.usuarios = documentos.compactMap { (queryDocumentSnapshot) -> Usuario? in
                     return try? queryDocumentSnapshot.data(as: Usuario.self)
                 }
             }
         }
     }

     /* Función que obtiene un usuario */
     func getUsuario() {
         bd.collection("usuarios").whereField("correo", isEqualTo: Auth.auth().currentUser!.email!)
             .addSnapshotListener { (querySnapshot, error) in
             guard let documentos = querySnapshot?.documents else {
                 self.alertMensaje = "Se ha producido un error al cargar los códigos"
                 self.alert.toggle()
                 print("No documents")
                 return
             }
             DispatchQueue.main.async {
                 self.usuarios = documentos.compactMap { (queryDocumentSnapshot) -> Usuario? in
                     return try? queryDocumentSnapshot.data(as: Usuario.self)
                 }
             }
         }
     }

     /* Función que obtiene un usuario de la base de datos
      * Parámetro: ref -> referencia del usuario que se va a obtener
      */
     func getUsuario(ref: String) {
         bd.collection("usuarios").document(ref).getDocument { (document, error) in
             if let document = document, document.exists {
                 let usuarioDatos = document.data().map(String.init(describing:)) ?? "nil"
                 print(usuarioDatos)
             } else {
                 self.alertMensaje = "Se ha producido un error con este usuario"
                 self.alert.toggle()
                 print("El usuario no existe")
             }
             DispatchQueue.main.async {
                 self.usuario = document.map { queryDocumentSnapshot -> Usuario in
                     let data = queryDocumentSnapshot.data()
                     //let id = document?.documentID
                     let nombre = data?["nombre"] as? String ?? ""
                     let nick = data?["nick"] as? String ?? ""
                     let correo = data?["correo"] as? String ?? ""
                     //let password = data?["password"] as? String ?? ""
                     let imagen = data?["foto"] as? String ?? ""
                     return Usuario(nombre: nombre, nick: nick, correo: correo, foto: imagen)
                 }!
             }
         }
     }
     
     
     /* Función que elimina un usuario de la base de datos, a través de su id
      * Parámetro: id -> id del usuario que se va a eliminar
      */
     func eliminar(id: String) {
         bd.collection("usuarios").document(id).delete() { (error) in
             if let error = error {
                 print("Error al eliminar", error.localizedDescription)
                 self.alertMensaje = "Error al eliminar el usuario"
                 self.alert.toggle()
             } else {
                 print("Elimino")
             }
         }
     }
}*/
