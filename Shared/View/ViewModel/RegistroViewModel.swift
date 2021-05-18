//
//  RegistroViewModel.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 08/05/2021.
//

import Foundation
import FirebaseAuth
import Combine

class RegistroViewModel : ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmarPass: String = ""
    @Published var logueado = false

    var signedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func registrar() {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (resultado, error) in
            guard resultado != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.logueado = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { [weak self] (resultado, error) in
            guard resultado != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.logueado = true
            }
        }
    }
    
    func logout(){
        try? Auth.auth().signOut()
        self.logueado = false
    }
    
}
