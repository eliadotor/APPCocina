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
    @Published var emailVerificado = false
    
    var signedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var emailValidado: Bool {
        return ((Auth.auth().currentUser?.isEmailVerified) != nil)
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
    
    func enviarEmailConfirmacion() {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            guard error == nil else {
                return
            }
                    
        }
        
    }
    
    func recuperarPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if self.email.isEmpty == true || error != nil {
                    // Alerta
                }
                if error == nil && self.email.isEmpty == false{
                    // Alerta
                }
            }
        }
    }
}
