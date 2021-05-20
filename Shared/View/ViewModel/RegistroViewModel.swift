//
//  RegistroViewModel.swift
//  APPCocina (iOS)
//
//  Clase que se encarga de gestionar el registro y el inicio de sesión
//  de los usuarios.
//
//  Created by Elia Dotor Puente on 08/05/2021.
//

import Foundation
import FirebaseAuth
import Combine

class RegistroViewModel : ObservableObject {
    
    // Entrada de datas del usuario
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmarPass: String = ""
    
    // Valores de validación del formulario
    @Published var emailValido: Bool = false
    @Published var passwordLongitudValida: Bool = false
    @Published var passwordValida: Bool = false
    @Published var passwordCoincide: Bool = false
    @Published var acepto: Bool = false


    private var cancellableObects: Set<AnyCancellable> = []
    
    // Comprobar estado

    @Published var logueado = false
    @Published var emailVerificado = false
    
    var signedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var emailValidado: Bool {
        return ((Auth.auth().currentUser?.isEmailVerified) != nil)
    }
    
    
    
    init() {
        // Validación email
        $email
            .receive(on: RunLoop.main)
            .map{ email in
                let pattern = "[A-Z0-9a-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                if let _ = email.range(of: pattern, options: .regularExpression){
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.emailValido, on: self)
            .store(in: &cancellableObects)
        
        // Validación longitud de contraseña
        $password
            .receive(on: RunLoop.main)
            .map{ password in
                return password.count >= 6
            }
            .assign(to: \.passwordLongitudValida, on: self)
            .store(in: &cancellableObects)
        
        // Validación contraseña con al menos un número, una mayúscula y una minúscula
        $password
            .receive(on: RunLoop.main)
            .map{ password in
                let pattern = "(?=.*\\d+)(?=.*[A-Z]+)(?=.*[a-z]+)"
                if let _ = password.range(of: pattern, options: .regularExpression){
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.passwordValida, on: self)
            .store(in: &cancellableObects)
        
        // Validación coincidencia de contraseña
        Publishers.CombineLatest($password, $confirmarPass)
            .receive(on: RunLoop.main)
            .map{ (password, confirmarPass) in
                return !password.isEmpty && (password == confirmarPass)
            }
            .assign(to: \.passwordCoincide, on: self)
            .store(in: &cancellableObects)
    }
    
    
    /* Función que registra usuarios después de comproabar que no están
       ya registrados */
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
    
    /* Función para iniciar sesión después de comproabar
       el email y la contraseña */
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
    
    /* Función para cerrar sesión */
    func logout(){
        try? Auth.auth().signOut()
        self.logueado = false
    }
    
    /* Función que envia un email con un link de verificación de la cuenta */
    func enviarEmailConfirmacion() {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            guard error == nil else {
                return
            }
                    
        }
        
    }
    
    /* Función que envia un email con un link de recuperación de la contraseña */
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
