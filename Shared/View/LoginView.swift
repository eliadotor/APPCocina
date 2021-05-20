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
                SingleFormView(nombreCampo: "Email", valorCampo: $viewModel.email)
                // SecureField
                SingleFormView(nombreCampo: "Contraseña", valorCampo: $viewModel.password, protegido: true)
            }.padding()
                Button(action: {
                    guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
                        return
                    }
                    viewModel.login()
                }, label: {
                    Text("Entrar")
                })
                .buttonStyle(EstiloBoton())
                .background(NavigationLink("",
                                           destination: RegistroView()))
                NavigationLink("Crear una cuenta",
                                       destination: RegistroView())
                    .padding()
                    .foregroundColor(.orange)
            

            Button(action: {
                guard !viewModel.email.isEmpty else {
                    return
                }
                viewModel.recuperarPassword()
            }, label: {
                Text("¿Olvidaste la contraseña?")
            })
            .foregroundColor(.orange)
            Spacer()
        }.navigationBarHidden(true)
    }
    
}
