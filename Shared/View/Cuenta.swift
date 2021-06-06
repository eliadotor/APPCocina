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
        if viewModel.logueado {
            VStack (alignment: .leading){
                HStack {
                    VStack {
                        Text("Cuenta")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                    }
                    .accessibility(addTraits: .isHeader)
                    Spacer()
                }
                ForEach(self.viewModel.usuarios) { usuario in
                    HStack {
                        ImagenCuentaStorage(imagenUrl: usuario.foto)
                        VStack(alignment: .leading){
                            Text(usuario.nombre)
                            Text(usuario.nick)
                        }
                    }
                }
                Button(action: {
                    irARecetas = true
                    
                }, label: {
                    Text("Mis recetas")
                        .foregroundColor(Color.orange)
                }).background(NavigationLink("",
                                             destination: MisRecetasView().environmentObject(RecetaViewModel()), isActive: $irARecetas))
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
                Spacer()
            }.padding()
            .navigationBarTitle("Mi cuenta", displayMode: .inline)
            .onAppear {
                self.viewModel.logueado = viewModel.signedIn
                self.viewModel.getUsuario()
            }
        }
    }
}

/*
 var body: some View {
     ScrollView {
         //if viewModel.logueado {
             VStack {
                 HStack {
                     VStack (alignment: .leading){
                         Text("Mi cuenta")
                             .font(.title2)
                             .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                             .padding(.bottom)
                         
                     }
                     .accessibility(addTraits: .isHeader)
                     Spacer()
                 }
                 HStack {
                     /*ImagenCuentaStorage(imagenUrl: viewModelUsuario.usuarios[0].foto)
                     VStack(alignment: .leading){
                         Text(viewModelUsuario.usuarios[0].nombre)
                         Text(viewModelUsuario.usuarios[0].nick)
                     }*/
                 }
                 Button(action: {
                     irARecetas = true
                     
                 }, label: {
                     Text("Mis recetas")
                         .foregroundColor(Color.orange)
                 }).background(NavigationLink("",
                                              destination: MisRecetasView().environmentObject(RecetaViewModel()), isActive: $irARecetas))
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
                 viewModelUsuario.getUsuario()
             }
             /*.toolbar {
                 ToolbarItem (placement: .navigationBarLeading){
                     //Text("Hola, \(viewModelUsuario.usuarios[0].nick)!")
                 }
                 ToolbarItem (placement: .navigationBarTrailing){
                     Button(action: {
                         viewModel.logout()
                     }, label: {
                         Text("Cerrar sesión")
                             .foregroundColor(Color.orange)
                     }).background(NavigationLink("",
                                                 destination: LoginView()))
                 }
             }*/
        // }
     }
 }
 */
