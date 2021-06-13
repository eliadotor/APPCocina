
//
//  DetallesReceta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct DetallesRecetaView: View {
    var refReceta = ""
    @State var irARecetas = false
    @State var comenzarReceta = false
    var crear = false
    @ObservedObject private var viewModelR = RecetaViewModel()
    @ObservedObject private var viewModelI = IngredienteViewModel()
    @ObservedObject private var viewModel = PasoViewModel()
    @State private var mostrarAlerta = false
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading){
                ImagenRecetaStorage(imagenUrl: viewModelR.receta.foto)
                    .accessibilityHidden(true)
                Text(viewModelR
                        .receta.titulo)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                    .accessibility(addTraits: .isHeader)
                HStack {
                    Text("\(viewModelR.receta.duracion) min")
                        .font(.system(size: 18))
                    Text("| ")
                        .font(.system(size: 18))
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    Text("\(viewModelR.receta.puntuacion) estrellas")
                        .font(.system(size: 18))
                }.padding(.horizontal)
                VStack (alignment: .leading, spacing: 6){
                    Text("INGREDIENTES")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.vertical, 6)
                        .accessibility(addTraits: .isHeader)
                    ForEach(viewModelI.ingredientes) { ingrediente in
                        HStack() {
                            Text("\(ingrediente.cantidad)")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                                .accessibilityHidden(true)
                            if ingrediente.unidad != ""{
                                Text(ingrediente.unidad)
                                    .foregroundColor(.orange)
                                    .fontWeight(.bold)
                                    .accessibilityHidden(true)
                                Text("de")
                                    .accessibilityHidden(true)
                            }
                            Text(ingrediente.nombre)
                            Spacer()
                        }
                        .accessibilityLabel(ingrediente.unidad != "" ? "\(ingrediente.cantidad) \(ingrediente.unidad) de \(ingrediente.nombre)." : "\(ingrediente.cantidad) \(ingrediente.nombre).")
                    }
                    Text("PASOS")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.vertical, 6)
                        .accessibility(addTraits: .isHeader)
                        .padding(.top)
                    ForEach(viewModel.pasos) { paso in
                        HStack() {
                            Text(paso.descripcion)
                            Spacer()
                            if paso.duracion != 0{
                                Text("\(paso.duracion) min")
                                    .foregroundColor(.orange)
                                    .fontWeight(.bold)
                                    .accessibilityHidden(true)
                            }
                        }
                        .accessibilityLabel(paso.duracion>0 ? "\(paso.descripcion) \(paso.duracion) minutos." : "\(paso.descripcion).")
                    }
                }.padding(.horizontal)
                .onAppear() {
                    self.viewModelR.getReceta(ref: refReceta)
                    self.viewModelI.getIngredientes(ref: refReceta)
                    self.viewModel.getPasos(ref: refReceta)
                }
                Button(action: {
                    mostrarAlerta = true
                }, label: {
                    HStack {
                        Spacer()
                        Text("Comenzar receta")
                        Spacer()
                    }
                }).buttonStyle(EstiloBoton())
                .background(
                    NavigationLink("", destination: PasoView(refReceta: refReceta, paso: 1), isActive: $comenzarReceta)
                        .accessibilityHidden(true)
                )
                .padding([.horizontal, .bottom])
                Spacer()
            }.edgesIgnoringSafeArea(.top)
            .navigationBarHidden(crear ? true : false)
            .alert(isPresented: $mostrarAlerta) {
                Alert(title: Text("Importante"), message: Text("¿Está seguro de que desea realizar la receta?"), primaryButton: .cancel(Text("No")), secondaryButton:
                        .default(Text("Sí")) {
                            comenzarReceta = true
                        })
            }
            .overlay(
                HStack {
                    Spacer()
                    VStack {
                        if crear {
                            Button(action: {
                                irARecetas = true
                            }, label: {
                                Text("Recetas")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            })
                            .padding(.trailing, 20)
                            .padding(.top, 5)
                            .background(NavigationLink("",
                                destination: ContentView(seleccionado: 1), isActive: $irARecetas))
                            Spacer()
                        }
                    }
                }
            )
        }
    }
}

