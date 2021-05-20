//
//  RegistroView.swift
//  APPCocina (iOS)//
//  Created by Elia Dotor Puente on 18/05/2021.
//

import SwiftUI

struct RegistroView: View {
    @EnvironmentObject var viewModel: RegistroViewModel
    @Environment(\.presentationMode) var modoPresentacion
    @State var isOn: Bool = false
    
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
                    .textContentType(.emailAddress)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
                SecureField("Contraseña", text: $viewModel.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
                SecureField("Confirmar contraseña", text: $viewModel.confirmarPass)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                    .padding(.vertical)
                HStack{
                    Toggle("", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: .orange))
                    .labelsHidden()
                    Text(" Acepto la")
                    NavigationLink("política de privacidad",
                                           destination: EmptyView())
                        .foregroundColor(.orange)
                    Spacer()
                }.padding(.top)
            }.padding()
                Button(action: {
                    guard !viewModel.email.isEmpty, !viewModel.password.isEmpty, viewModel.password == viewModel.confirmarPass else {
                        return
                    }
                    viewModel.registrar()
                }, label: {
                    Text("Registrarse")
                })
                .background(NavigationLink("",
                                           destination: LoginView()),
                            alignment: .center)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .font(.title2)
                .foregroundColor(.white)
                .frame(height: 45)
                .background(Color.orange)
                .cornerRadius(10)
                .padding()
                NavigationLink("Iniciar sesión",
                                       destination: LoginView())
                    .foregroundColor(.orange)
            Spacer()
        }.navigationBarHidden(true)
    }
}
struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView().environmentObject(RegistroViewModel())
    }
}
