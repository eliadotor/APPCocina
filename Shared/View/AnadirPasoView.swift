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
    @Binding var irAAnadirPasos: Bool
    @State var irAListaPasos = false
    @StateObject var viewModel = PasoViewModel()
    @State var anadir: Bool = false
    @State var anadirMas: Bool = false

    var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Section(header: Text("Descripción")) {
                    TextField("", text: $viewModel.paso.descripcion)
                        .disabled(anadir ? true : false)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                        .padding(.bottom)
                }
        
                Section(header: Text("Duración")){
                    TextField("", value: $viewModel.paso.duracion, formatter: NumberFormatter())
                        .disabled(anadir ? true : false)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                        .padding(.bottom)
                }
                Button(action: {
                    self.anadir = true
                    viewModel.anadirPaso(ref: self.receta)

                }, label: {
                    HStack {
                        Spacer()
                        Text(anadir ? "Añadido" : "Añadir paso")
                        Spacer()
                    }
                }).disabled(anadir)
                .buttonStyle(EstiloBoton())
                Button(action: {
                    self.anadirMas = true
                    self.anadir = false
                }, label: {
                    HStack {
                        Spacer()
                        Text("Añadir más pasos")
                        Spacer()
                    }
                })
                .buttonStyle(EstiloBoton())
                Button(action: {
                    irAListaPasos = true
                }, label: {
                    HStack {
                        Spacer()
                        Text("Guardar receta")
                        Spacer()
                    }
                }).background(
                    NavigationLink("", destination: DetallesPasosView(refReceta: receta, irAAnadirPasos: $irAAnadirPasos, irAListaPasos: $irAListaPasos), isActive: $irAListaPasos)
                    .hidden()
                )
                .buttonStyle(EstiloBoton())
                Spacer()
            }.padding()
            .navigationBarTitle("Pasos", displayMode: .inline)

        }
    }

