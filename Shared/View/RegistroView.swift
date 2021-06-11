//
//  RegistroView.swift
//  APPCocina (iOS)//
//  Created by Elia Dotor Puente on 18/05/2021.
//

import SwiftUI

struct RegistroView: View {
    @EnvironmentObject var viewModel: RegistroViewModel
    @Environment(\.presentationMode) var modoPresentacion
    @State var registrar: Bool = false
    
    var body: some View {
        ScrollView {
            Image("TRAC")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .padding(.top)
                .accessibilityHidden(true)
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
                    
                        ValidacionFormularioView(nombreIcono: viewModel.passwordValida ? "checkmark.circle.fill" : "xmark.circle", colorIcono: viewModel.passwordValida ? Color.green : Color.red, texto: "Debe contener mayúsculas, minúsculas y números")
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
        .alert(isPresented: $viewModel.alert, content: {
            Alert(title: Text("¡Importante!"), message: Text(viewModel.alertMensaje), dismissButton: .cancel(Text("Aceptar")))
        })
    }
}
