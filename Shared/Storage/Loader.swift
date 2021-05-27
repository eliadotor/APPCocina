//
//  Loader.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 27/05/2021.
//

import Foundation
import Firebase
import Combine


class Loader: ObservableObject {
    var didChange = PassthroughSubject<Data?,Never>()
    
    @Published var data: Data? = nil {
        didSet {
            didChange.send(data)
        }
    }
    
    init(imagenUrl: String) {
        let storageImagen = Storage.storage().reference(forURL: imagenUrl)
        storageImagen.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error al traer imagenes", error.localizedDescription)
            } else {
                 DispatchQueue.main.async {
                     self.data = data
                 }
            }
        }
    }
}
