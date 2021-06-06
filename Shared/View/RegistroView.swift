//
//  RegistroView.swift
//  APPCocina (iOS)//
//  Created by Elia Dotor Puente on 18/05/2021.
//

import SwiftUI

struct RegistroView: View {
    @EnvironmentObject var viewModel: RegistroViewModel
    //@EnvironmentObject var viewModelUsuario: UsuarioViewModel()
    @Environment(\.presentationMode) var modoPresentacion
    @State var registrar: Bool = false
    
    var body: some View {
        ScrollView {
            Text("APP de Cocina")
                .font(.title)
                .foregroundColor(.white)
                .padding(
                    [.top, .bottom]
                )

            Image(systemName: "timer")
                .font(.largeTitle)
                .foregroundColor(.orange)
            VStack {
                // TextField
                SingleFormView(nombreCampo: "Nombre", valorCampo: $viewModel.usuario.nombre)
                // TextField
                SingleFormView(nombreCampo: "Nick", valorCampo: $viewModel.usuario.nick)
                // TextField
                SingleFormView(nombreCampo: "Email", valorCampo: $viewModel.email)
                    .keyboardType(.emailAddress)
                if !viewModel.email.isEmpty {
                    ValidacionFormularioView(nombreIcono: viewModel.emailValido ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.emailValido ? Color.green : Color.red, texto: "Tiene que ser un correo válido")
                        .padding(.horizontal)
                }
                // SecureField
                SingleFormView(nombreCampo: "Contraseña", valorCampo: $viewModel.password, protegido: true)
                if !viewModel.password.isEmpty {
                        ValidacionFormularioView(nombreIcono: viewModel.passwordLongitudValida ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordLongitudValida ? Color.green : Color.red,
                                                    texto: "Mínimo 6 caracteres")
                            .padding(.horizontal)
                    
                        ValidacionFormularioView(nombreIcono: viewModel.passwordValida ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordValida ? Color.green : Color.red, texto: "Mínimo una mayúscula y un número")
                            .padding(.horizontal)
                }
                // SecureField
                SingleFormView(nombreCampo: "Confirmar contraseña", valorCampo: $viewModel.confirmarPass, protegido: true)
                if !viewModel.confirmarPass.isEmpty {
                    ValidacionFormularioView(nombreIcono: viewModel.passwordCoincide ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordCoincide ? Color.green : Color.red, texto: "Las dos contraseñas deben coincidir")
                        .padding(.horizontal)
                }
                HStack{
                    Toggle("", isOn: $viewModel.acepto)
                    .toggleStyle(SwitchToggleStyle(tint: .orange))
                    .labelsHidden()
                    Text(" Acepto la")
                    NavigationLink("política de privacidad",
                                           destination: EmptyView())
                        .foregroundColor(.orange)
                    
                    Spacer()
                }.padding(.top)
                if registrar && !viewModel.acepto {
                    ValidacionFormularioView(nombreIcono: viewModel.acepto ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.acepto ? Color.green : Color.red, texto: "Debe aceptar la política de privacidad")
                        .padding(.horizontal)
                }
            }.padding()
                Button(action: {
                    viewModel.usuario.correo = viewModel.email
                    registrar = true
                    viewModel.registrar()
                    //viewModel.anadirUsuario()
                }, label: {
                    Text("Registrarse")
                })
                .background(NavigationLink("",
                                           destination: LoginView()),
                            alignment: .center)
                .buttonStyle(EstiloBoton())
                NavigationLink("Iniciar sesión",
                                       destination: LoginView())
                    .foregroundColor(.orange)
            Spacer()
        }.navigationBarHidden(true)
        /*.onAppear() {
            viewModelUsuario.usuario.correo = viewModel.email
            viewModelUsuario.usuario.password = viewModel.password
        }*/
        .alert(isPresented: $viewModel.alert, content: {
            Alert(title: Text("¡Importante!"), message: Text(viewModel.alertMensaje), dismissButton: .cancel(Text("Aceptar")))
        })
    }
}
/*struct RegistroView: View {
 @ObservedObject var viewModel = RegistroViewModel()
 @ObservedObject var viewModelUsuario = UsuarioViewModel()
 @Environment(\.presentationMode) var modoPresentacion
 @State var registrar: Bool = false
 
 var body: some View {
     ScrollView {
         Text("APP de Cocina")
             .font(.title)
             .foregroundColor(.white)
             .padding(
                 [.top, .bottom]
             )

         Image(systemName: "timer")
             .font(.largeTitle)
             .foregroundColor(.orange)
         VStack {
             // TextField
             SingleFormView(nombreCampo: "Nombre", valorCampo: $viewModelUsuario.usuario.nombre)
             // TextField
             SingleFormView(nombreCampo: "Nick", valorCampo: $viewModelUsuario.usuario.nick)
             // TextField
             SingleFormView(nombreCampo: "Email", valorCampo: $viewModel.email)
                 .keyboardType(.emailAddress)
             if !viewModel.email.isEmpty {
                 ValidacionFormularioView(nombreIcono: viewModel.emailValido ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.emailValido ? Color.green : Color.red, texto: "Tiene que ser un correo válido")
                     .padding(.horizontal)
             }
             // SecureField
             SingleFormView(nombreCampo: "Contraseña", valorCampo: $viewModel.password, protegido: true)
             
             if !viewModel.password.isEmpty {
                     ValidacionFormularioView(nombreIcono: viewModel.passwordLongitudValida ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordLongitudValida ? Color.green : Color.red,
                                                 texto: "Mínimo 6 caracteres")
                         .padding(.horizontal)
                 
                     ValidacionFormularioView(nombreIcono: viewModel.passwordValida ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordValida ? Color.green : Color.red, texto: "Mínimo una mayúscula y un número")
                         .padding(.horizontal)
                 
             }
             // SecureField
             SingleFormView(nombreCampo: "Confirmar contraseña", valorCampo: $viewModel.confirmarPass, protegido: true)
             if !viewModel.confirmarPass.isEmpty {
                 ValidacionFormularioView(nombreIcono: viewModel.passwordCoincide ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordCoincide ? Color.green : Color.red, texto: "Las dos contraseñas deben coincidir")
                     .padding(.horizontal)
             }
             HStack{
                 Toggle("", isOn: $viewModel.acepto)
                 .toggleStyle(SwitchToggleStyle(tint: .orange))
                 .labelsHidden()
                 Text(" Acepto la")
                 NavigationLink("política de privacidad",
                                        destination: EmptyView())
                     .foregroundColor(.orange)
                 
                 Spacer()
             }.padding(.top)
             if registrar && !viewModel.acepto {
                 ValidacionFormularioView(nombreIcono: viewModel.acepto ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.acepto ? Color.green : Color.red, texto: "Debe aceptar la política de privacidad")
                     .padding(.horizontal)
             }
         }.padding()
             Button(action: {
                 viewModelUsuario.usuario.correo = viewModel.email
                 viewModelUsuario.usuario.password = viewModel.password
                 registrar = true
                 viewModel.registrar()
                 viewModelUsuario.anadirUsuario()
             }, label: {
                 Text("Registrarse")
             })
             .background(NavigationLink("",
                                        destination: LoginView()))
             .buttonStyle(EstiloBoton())
             NavigationLink("Iniciar sesión",
                                    destination: LoginView())
                 .foregroundColor(.orange)
         Spacer()
     }.navigationBarHidden(true)
     /*.onAppear() {
         viewModelUsuario.usuario.correo = viewModel.email
         viewModelUsuario.usuario.password = viewModel.password
     }*/
     .alert(isPresented: $viewModel.alert, content: {
         Alert(title: Text("¡Importante!"), message: Text(viewModel.alertMensaje), dismissButton: .cancel(Text("Aceptar")))
     })
 }
}
*/
