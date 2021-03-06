//
//  LoginView.swift
//  APPCocina (iOS)//
//  Created by Elia Dotor Puente on 08/05/2021.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: RegistroViewModel
    @Environment(\.presentationMode) var modoPresentacion
    @State var irAHome = false
    
    var body: some View {
        VStack {
            Image("TRAC")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .accessibilityLabel("Inicia sesión")
            VStack {
                // TextField
                SingleFormView(nombreCampo: "Email", valorCampo: $viewModel.email)
                    .keyboardType(.emailAddress)
                // SecureField
                SingleFormView(nombreCampo: "Contraseña", valorCampo: $viewModel.password, protegido: true)
            }.padding()
                Button(action: {
                    viewModel.login()
                }, label: {
                    Text("Entrar")
                })
                .buttonStyle(EstiloBoton())
                .background(NavigationLink("", destination: ContentView(seleccionado: 0))
                                .accessibilityHidden(true)
                )
                NavigationLink("Crear una cuenta",
                                       destination: RegistroView())
                    .padding(.bottom)
                    .foregroundColor(.orange)

            Button(action: {
                viewModel.recuperarPassword()
            }, label: {
                Text("¿Olvidaste la contraseña?")
            })
            .foregroundColor(.orange)
            Spacer()
        }
        .alert(isPresented: $viewModel.alert, content: {
            Alert(title: Text("¡Importante!"), message: Text(viewModel.alertMensaje), dismissButton: .cancel(Text("Aceptar")))
        })
    }
    
}
