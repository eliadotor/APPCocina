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


class CodigosViewModel: ObservableObject {
    private var bd = Firestore.firestore()
    let storage = Storage.storage()


    @Published var codigos: Array = [CodigoQR]()
    @Published var codigo: CodigoQR
    
    @Published var nuevoCodigoRef: DocumentReference? = nil
    

    let contexto = CIContext()
    let filtro = CIFilter.qrCodeGenerator()
    
    
    
    init(codigo: CodigoQR = CodigoQR(imagenURL: "", descripcion: "", fecha: Date(), caducidad: Date(), userId: Auth.auth().currentUser!.uid)){
        self.codigo = codigo
    }
    
    
    /* Función que genera códigosQR */
    func generarCodigoQR(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filtro.setValue(data, forKey: "inputMessage")

        if let outputImage = filtro.outputImage {
            if let cgimg = contexto.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
    func guardarImgCodigo(ref: String, imagen: UIImage) {
        if let imagenData = imagen.jpegData(compressionQuality: 0.4) {
            let storageRef = self.storage.reference()
            let codigoRef = storageRef.child("codigos").child(ref)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            codigoRef.putData(imagenData, metadata: metadata) { (_, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
            }
             
             codigoRef.downloadURL { url, error in
              if let error = error {
                print(error.localizedDescription)
              } else {
                //
                
              }
            }
        }
    }
    
    /* */
    func getImgCodigo(ref: String) -> UIImage {
        var imagen: UIImage?
    
        let storageRef = self.storage.reference(forURL: ref)
        let codigoRef = storageRef.child("codigos").child(ref)
        codigoRef.getData(maxSize: 1 * 1024 * 1024) { imagenData, error in
            if let error = error {
                print(error)
            } else {
                if let imagenData = imagenData {
                    imagen = UIImage(data: imagenData)
                }
            }
          }
        return imagen!
    }
    
    
    /* Función que añade un códigoQR a la base de datos */
    func anadirCodigo() -> String {
        do {
            nuevoCodigoRef = try bd.collection("codigos").addDocument(from: codigo)
        }
        catch {
            print(error)
        }
        return nuevoCodigoRef!.documentID
    }
    
    
    func modificarCodigo(ref: String){
        do {
            try bd.collection("codigos").document(ref).setData(from: codigo)
        }
        catch {
            print(error)
        }
    }
    
    /* Función que obtiene todos los códigosQR de un usuario
       de la base de datos */
    func getCodigos() {
        bd.collection("codigos").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
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
                print("El código no existe")
            }
            
            self.codigo = document.map { queryDocumentSnapshot -> CodigoQR in
                let data = queryDocumentSnapshot.data()
                let imagen = data?["imagenURL"] as? String ?? ""
                let descripcion = data?["descripcion"] as? String ?? ""
                let fecha = data?["fecha"] as? Date
                let fechaCaducidad = data?["caducidad"] as? Date
                let userID = data?["userId"] as? String ?? ""
                return CodigoQR(imagenURL: imagen, descripcion: descripcion, fecha: fecha, caducidad: fechaCaducidad, userId: userID)
            }!
        }
    }
    
}
