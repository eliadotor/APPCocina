//
//  CodigosViewModel.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 22/05/2021.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import CoreImage.CIFilterBuiltins
import CodeScanner
import Combine

let imgUrl = "gs://appcocina-5d597.appspot.com/codigos/codigo.jpg"
class CodigosViewModel: ObservableObject {
    private var bd = Firestore.firestore()
    let storage = Storage.storage()


    @Published var codigos: Array = [CodigoQR]()
    @Published var codigo: CodigoQR
    
    @Published var campos: [String:Any] = [:]

    @Published var id = ""
    @Published var nuevoCodigoRef: DocumentReference? = nil
    
    // Validación códigos
    @Published var titulo: String = ""
    @Published var tituloValido: Bool = true

    private var cancellableObects: Set<AnyCancellable> = []
    
    // Alertas
    @Published var alert = false
    //@Published var alerta = false
    @Published var alertMensaje = ""
    
    // Atributos para generar códigosQR
    let contexto = CIContext()
    let filtro = CIFilter.qrCodeGenerator()
    

    init(codigo: CodigoQR = CodigoQR(id: "", imagenURL: imgUrl, titulo: "Código vacío", descripcion: "", fecha: Date(), caducidad: Date(), userId: Auth.auth().currentUser!.uid)){
        self.codigo = codigo
        
        // Validación longitud de título
        $titulo
            .receive(on: RunLoop.main)
            .map{ titulo in
                return titulo.count <= 15
            }
            .assign(to: \.tituloValido, on: self)
            .store(in: &cancellableObects)
    }


    /* Función que genera códigosQR y devuelve la imagen del código creado */
    func generarCodigoQR(from texto: String) -> UIImage {
        let data = Data(texto.utf8)
        filtro.setValue(data, forKey: "inputMessage")

        if let outputImage = filtro.outputImage {
            if let img = contexto.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: img)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }

    /* Función que guarda la imagen en la base de datos */
    func guardarImgCodigo(imagen: UIImage) {
        let storageRef = self.storage.reference()
        let nombreImagen = UUID()
        let directorio = storageRef.child("codigos/\(nombreImagen)")
        let imagenData = imagen.jpegData(compressionQuality: 0.4)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        directorio.putData(imagenData, metadata: metadata) { (data, error) in
            if error == nil {
                print("Guardo imagen")
                self.codigo.imagenURL = String(describing: directorio)
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
    }

    /* Función que añade un códigoQR a la base de datos e inmediatamente lo
       modifica para añadirle el id del documento generado en la base de datos */
    func anadirCodigo() -> String {
        do {
            nuevoCodigoRef = try bd.collection("codigos").addDocument(from: codigo)
        }
        catch {
            print(error)
        }
        bd.collection("codigos").document(nuevoCodigoRef!.documentID).updateData(["id" : nuevoCodigoRef!.documentID]) { (error) in
            if let error = error {
                print("Error al editar", error.localizedDescription)
                self.alertMensaje = "Error al guardar el códigoQR"
                self.alert.toggle()
            } else {
                print("Id añadido")
            }
        }
        return nuevoCodigoRef!.documentID
    }

    /* Función que modifica un códigoQR en la base de datos */
    func modificarCodigo(id: String){
        self.campos = [
            "titulo" : codigo.titulo,
            "descripcion" : codigo.descripcion,
            "fecha" : codigo.fecha,
            "caducidad" : codigo.caducidad
        ]
        bd.collection("codigos").document(id).updateData(campos) { (error) in
            if let error = error {
                print("Error al editar", error.localizedDescription)
                self.alertMensaje = "Error al modificar el códigoQR"
                self.alert.toggle()
            } else {
                print("Edito")
            }
        }
       
    }

    /* Función que obtiene todos los códigosQR de un usuario
       de la base de datos */
    func getCodigos() {
        bd.collection("codigos").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                self.alertMensaje = "Se ha producido un error al cargar los códigos"
                self.alert.toggle()
                print("No documents")
                return
            }

            self.codigos = documentos.compactMap { (queryDocumentSnapshot) -> CodigoQR? in
                return try? queryDocumentSnapshot.data(as: CodigoQR.self)
            }
        }
    }

    /* Función que obtiene un códigoQR de la base de datos */
    func getCodigo(ref: String) {
        bd.collection("codigos").document(ref).getDocument { (document, error) in
            if let document = document, document.exists {
                let codigoDatos = document.data().map(String.init(describing:)) ?? "nil"
                print(codigoDatos)
            } else {
                self.alertMensaje = "Se ha producido un error con este código"
                self.alert.toggle()
                print("El código no existe")
            }

            self.codigo = document.map { queryDocumentSnapshot -> CodigoQR in
                let data = queryDocumentSnapshot.data()
                let  id = document?.documentID
                let imagen = data?["imagenURL"] as? String ?? ""
                let titulo = data?["titulo"] as? String ?? ""
                let descripcion = data?["descripcion"] as? String ?? ""
                let fecha = data?["fecha"] as? Date ?? Date()
                let fechaCaducidad = data?["caducidad"] as? Date ?? Date()
                let userID = data?["userId"] as? String ?? ""
                return CodigoQR(id: id!, imagenURL: imagen, titulo: titulo, descripcion: descripcion, fecha: fecha, caducidad: fechaCaducidad, userId: userID)
            }!
        }
    }
    
    /* Función que obtiene un códigoQR de la base de datos mediante un id */
    func getRefCodigo(id: String) {
        bd.collection("codigos").whereField("id", isEqualTo: id)
                .addSnapshotListener { (querySnapshot, error) in
                guard let documentos = querySnapshot?.documents else {
                    self.alertMensaje = "Se ha producido un error con este código"
                    self.alert.toggle()
                    print("No existe el código")
                    return
                }

                self.codigos = documentos.compactMap { (queryDocumentSnapshot) -> CodigoQR? in
                    return try? queryDocumentSnapshot.data(as: CodigoQR.self)
                }
            }
    }
    
    /* Función que elimina un códigoQR de la base de datos, a través de su id */
    func eliminar(id: String) {
        bd.collection("codigos").document(id).delete() { (error) in
            if let error = error {
                print("Error al eliminar", error.localizedDescription)
                self.alertMensaje = "Error al eliminar el códigoQR"
                self.alert.toggle()
            } else {
                print("Elimino")
            }
        }
    }
}
