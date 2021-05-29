//
//  Cuenta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct Cuenta: View {
    @EnvironmentObject var viewModel: RegistroViewModel
    var irCuenta: Binding<Bool>
    @State var irARecetas = false
    @State var irACodigos = false

    var body: some View {
        ScrollView {
            if viewModel.logueado {
                VStack {
                    HStack {
                        VStack (alignment: .leading){
                            Text("Cuenta")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom)
                            
                        }
                        .accessibility(addTraits: .isHeader)
                        Spacer()
                    }
                    Button(action: {
                        irARecetas = true
                        
                    }, label: {
                        Text("Mis recetas")
                            .foregroundColor(Color.orange)
                    }).background(NavigationLink("",
                                                 destination: RecetasView(irARecetas: $irARecetas), isActive: $irARecetas))
                    Button(action: {
                        irACodigos = true
                    }, label: {
                        Text("Mis códigos")
                            .foregroundColor(Color.orange)
                    }).background(NavigationLink("",
                                                 destination: CodigosView().environmentObject(CodigosViewModel()), isActive: $irACodigos))
                    Button(action: {
                        viewModel.logout()
                    }, label: {
                        Text("Cerrar sesión")
                            .foregroundColor(Color.orange)
                    }).background(NavigationLink("",
                                                destination: LoginView()))
                }.padding()
                .onAppear {
                    viewModel.logueado = viewModel.signedIn
                }
            }
        }
    }
}
