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
    @State private var ref = "gs://appcocina-5d597.appspot.com/recetas/receta.jpg"
    @State private var refC = "gs://appcocina-5d597.appspot.com/codigos/codigo.jpg"
    @State private var refReceta = "zbwTGYYQH4Anp3KFn4tk"
    @State private var refCodigo = "zx3mKocuLpfwfIusCC8R"

    var body: some View {
        ScrollView {
            if viewModel.logueado {
                VStack (alignment: .leading){
                    VStack (alignment: .leading, spacing: 6){
                        ForEach(self.viewModel.usuarios) { usuario in
                            HStack {
                                VStack {
                                    Text("Hola, \(usuario.nick)")
                                        .font(.title2)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                }
                                .accessibility(addTraits: .isHeader)
                                Spacer()
                                VStack {
                                    Button(action: {
                                        viewModel.logout()
                                    }, label: {
                                        Text("Cerrar sesión")
                                            .font(.system(size: 14))
                                    }).background(NavigationLink("",
                                                                destination: LoginView()))
                                    .padding(.vertical)
                                }
                            }.padding(.bottom)
                            HStack {
                                ImagenCuentaStorage(imagenUrl: usuario.foto)
                                VStack(alignment: .leading){
                                    Text(usuario.nombre)
                                    Text(usuario.nick)
                                }
                            }
                        }
                    }
                    VStack{
                        Button(action: {
                            irARecetas = true
                            
                        }, label: {
                            VStack(alignment: .leading){
                                Label("Mis recetas", systemImage: "note.text")
                                .font(.title2)
                                HStack {
                                    NavigationLink(destination: DetallesRecetaView(refReceta: refReceta, crear: false)){
                                        VStack(alignment: .leading) {
                                            ImagenHomeStorage(imagenUrl: ref)
                                        }.padding(.horizontal,2)
                                    }
                                    NavigationLink(destination: DetallesRecetaView(refReceta: refReceta, crear: false)){
                                        VStack(alignment: .leading) {
                                            ImagenHomeStorage(imagenUrl: ref)
                                        }.padding(.horizontal,2)
                                    }
                                }
                            }
                        }).background(NavigationLink("",
                                                     destination: MisRecetasView().environmentObject(RecetaViewModel()), isActive: $irARecetas))
                        .padding(.vertical)
                        Button(action: {
                            irACodigos = true
                        }, label: {
                            VStack(alignment: .leading) {
                                Label("Mis códigos", systemImage: "qrcode.viewfinder")
                                    .font(.title2)
                                HStack {
                                    NavigationLink(destination: DetallesCodigoView(idCodigo: refCodigo, escaneado: false)){
                                        VStack(alignment: .leading) {
                                            ImagenHomeStorage(imagenUrl: refC)
                                        }
                                    }
                                    NavigationLink(destination: DetallesCodigoView(idCodigo: refCodigo, escaneado: false)){
                                        VStack(alignment: .leading) {
                                            ImagenHomeStorage(imagenUrl: refC)
                                            
                                        }
                                    }
                                }
                            }
                        }).background(NavigationLink("",
                                                     destination: CodigosView().environmentObject(CodigosViewModel()), isActive: $irACodigos))
                        .padding(.vertical)
                        Spacer()
                    }
                }.padding()
                .navigationBarHidden(true)
                .onAppear {
                    self.viewModel.getUsuario()
                }
            }
        }
    }
}
