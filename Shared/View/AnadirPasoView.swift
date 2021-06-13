//
//  AnadirPasoView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 10/05/2021.
//

import SwiftUI

struct AnadirPasoView: View {
    var receta: String
    var irAAnadirIngredientes: Binding<Bool>
    @State var irADetallesReceta = false
    @StateObject var viewModel = PasoViewModel()
    @State var anadir: Bool = false
    @State var anadirMas: Bool = false
    @State private var duracion = ""
    // Alertas
    @State var alert = false
    @State var alertMensaje = ""
    
    var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    VStack (alignment: .leading){
                        Text("Añadir Pasos")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                        
                    }
                    .accessibility(addTraits: .isHeader)
                    Spacer()
                }
                Section(header: Text("Descripción")) {
                    SingleFormView(nombreCampo: "", valorCampo: $viewModel.paso.descripcion)
                }
                Section(header: Text("Duración")){
                    SingleFormView(nombreCampo: "", valorCampo: $duracion)
                }
                Button(action: {
                    if viewModel.paso.descripcion.isEmpty {
                        self.alertMensaje = "Debe rellenar la descripción del paso"
                        self.alert.toggle()
                        return
                    }
                    viewModel.paso.duracion = Int(duracion) ?? 0
                    self.anadir = true
                    viewModel.anadirPaso(ref: self.receta)

                }, label: {
                    HStack {
                        Spacer()
                        Text(anadir ? "Añadido" : "Añadir paso")
                        Spacer()
                    }
                })
                .foregroundColor(anadir ? .secondary : .orange)
                .buttonStyle(EstiloBotonSecundario())
                .disabled(anadir)
                Button(action: {
                    self.anadirMas = true
                    self.anadir = false
                    viewModel.paso.descripcion = ""
                    duracion = ""
                }, label: {
                    HStack {
                        Spacer()
                        Text("Añadir más pasos")
                        Spacer()
                    }
                }).foregroundColor(.orange)
                .buttonStyle(EstiloBotonSecundario())
                Button(action: {
                    if !anadir && !anadirMas {
                        self.alertMensaje = "Debe añadir al menos un paso"
                        self.alert.toggle()
                        return
                    }
                    irADetallesReceta = true
                }, label: {
                    HStack {
                        Spacer()
                        Text("Guardar receta")
                        Spacer()
                    }
                }).background(
                    NavigationLink("", destination: DetallesRecetaView(refReceta: receta, crear: true), isActive: $irADetallesReceta)
                    .hidden()
                ).buttonStyle(EstiloBoton())
                Spacer()
            }.padding(.horizontal)
            .padding()
            .navigationBarTitle("Paso", displayMode: .inline)
            .alert(isPresented: $alert, content: {
                Alert(title: Text("¡Importante!"), message: Text(alertMensaje), dismissButton: .cancel(Text("Aceptar")))
            })
        }
    }
