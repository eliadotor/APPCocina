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
                TextField("Email", text: $viewModel.email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
                SecureField("Contraseña", text: $viewModel.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
            }.padding()
                Button(action: {
                    guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
                        return
                    }
                    viewModel.login()
                }, label: {
                    Text("Entrar")
                })
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .font(.title2)
                .foregroundColor(.white)
                .frame(height: 45)
                .background(Color.orange)
                .background(NavigationLink("",
                                           destination: RegistroView()))
                .cornerRadius(10)
                .padding()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(RegistroViewModel())
    }
}
