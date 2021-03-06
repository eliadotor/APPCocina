//
//  RegistroViewModel.swift
//  APPCocina (iOS)
//
//  Clase que se encarga de gestionar el registro y el inicio de sesión
//  de los usuarios y la creación, modificación y eliminación de los mismos.
//
//  Created by Elia Dotor Puente on 08/05/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine

let imageUrl = "gs://appcocina-5d597.appspot.com/usuarios/usuario.png"
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
    
    private var bd = Firestore.firestore()
    let storage = Storage.storage()
    
    @Published var usuarios: Array = [Usuario]()
    @Published var usuario: Usuario
    
    @Published var campos: [String:Any] = [:]

    @Published var nuevoUsuarioRef: DocumentReference? = nil
        
    // Alertas
    @Published var alert = false
    @Published var alertMensaje = ""
    
    var signedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var emailValidado: Bool {
        return ((Auth.auth().currentUser?.isEmailVerified) != nil)
    }
    
    
    // Constructor
    init(usuario: Usuario = Usuario(id: "", nombre: "", nick: "", correo: "", foto: imageUrl)){
        self.usuario = usuario
        
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
       ya registrados y validar que todos los datos sean correctos */
    func registrar() {
        if self.email.isEmpty || self.password.isEmpty || self.confirmarPass.isEmpty {
            self.alertMensaje = "Es necesario rellenar todos los campos"
            self.alert.toggle()
            return
        }
        
        if !emailValido {
            self.alertMensaje = "Error en el correo electrónico"
            self.alert.toggle()
            return
        }
        
        if !passwordValida || !passwordLongitudValida || !passwordCoincide {
            self.alertMensaje = "Error en la contraseña"
            self.alert.toggle()
            return
        }
        
        if !acepto {
            self.alertMensaje = "Debe aceptar la política de privacidad"
            self.alert.toggle()
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { resultado, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.alertMensaje = "Ya existe una cuenta con este correo electrónico"
                    self.alert.toggle()
                    return
                }
                if (resultado != nil) {
                    self.logueado = true
                    self.anadirUsuario(id: Auth.auth().currentUser!.uid)
                }
            }
        }
    }
    
    /* Función para iniciar sesión después de comproabar el email y la contraseña */
    func login() {
        if self.email.isEmpty || self.password.isEmpty {
            self.alertMensaje = "Es necesario rellenar todos los campos"
            self.alert.toggle()
            return
        }
        
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { resultado, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.alertMensaje = "El correo o la contraseña no es correcta"
                    self.alert.toggle()
                    return
                }
                self.logueado = true
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
            DispatchQueue.main.async {
                if self.email.isEmpty == true || error != nil {
                    self.alertMensaje = "Es necesario introducir un correo electrónico"
                    self.alert.toggle()
                }
                if error == nil && self.email.isEmpty == false{
                    self.alertMensaje = "Se ha enviado un link para validar la cuenta a su correo electrónico"
                    self.alert.toggle()
                }
            }
        }
    }
    
    /* Función que envia un email con un link de recuperación de la contraseña */
    func recuperarPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if self.email.isEmpty == true || error != nil {
                    self.alertMensaje = "Es necesario introducir un correo válido"
                    self.alert.toggle()
                }
                if error == nil && self.email.isEmpty == false{
                    self.alertMensaje = "Se ha enviado un link para restaurar la contraseña a su correo electrónico"
                    self.alert.toggle()
                }
            }
        }
    }
    
    /* Función que añade un usuario a la base de datos e inmediatamente lo
       modifica para añadirle el id del documento generado en la base de datos */
    func anadirUsuario(id: String) {
        do {
            nuevoUsuarioRef = try bd.collection("usuarios").addDocument(from: usuario)
        }
        catch {
            print(error)
        }
        bd.collection("usuarios").document(nuevoUsuarioRef!.documentID).updateData(["id" : id]) { (error) in
            if let error = error {
                print("Error al editar", error.localizedDescription)
                self.alertMensaje = "Error al guardar el usuario"
                self.alert.toggle()
            } else {
                print("Id añadido")
            }
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

    /* Función que obtiene un usuario */
    func getUsuario() {
        bd.collection("usuarios").whereField("id", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documentos = querySnapshot?.documents else {
                self.alertMensaje = "Se ha producido un error al cargar el usuario"
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
                    let id = data?["id"] as? String ?? ""
                    let nombre = data?["nombre"] as? String ?? ""
                    let nick = data?["nick"] as? String ?? ""
                    let correo = data?["correo"] as? String ?? ""
                    let imagen = data?["foto"] as? String ?? ""
                    return Usuario(id: id, nombre: nombre, nick: nick, correo: correo, foto: imagen)
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
}
