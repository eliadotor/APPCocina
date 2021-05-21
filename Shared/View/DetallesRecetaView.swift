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
    @ObservedObject private var viewModelR = RecetaViewModel()
    @ObservedObject private var viewModelI = IngredienteViewModel()
    @ObservedObject private var viewModel = PasoViewModel()
    @State private var comenzarReceta = false
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading){
                Image("\(viewModelR.receta.foto )")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(viewModelR
                        .receta.titulo)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
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
                            if ingrediente.unidad != ""{
                                Text(ingrediente.unidad)
                                    .foregroundColor(.orange)
                                    .fontWeight(.bold)
                                Text("de")
                            }
                            Text(ingrediente.nombre)
                            Spacer()
                        }
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
                            }
                        }
                    }
                }.padding(.horizontal)
                .onAppear() {
                    self.viewModelR.getReceta(ref: refReceta)
                    self.viewModelI.getIngredientes(ref: refReceta)
                    self.viewModel.getPasos(ref: refReceta)
                }
                Button(action: {
                    comenzarReceta = true
                }, label: {
                    HStack {
                        Spacer()
                        Text("Comenzar receta")
                        Spacer()
                    }
                }).buttonStyle(EstiloBoton())
                .padding([.horizontal, .bottom])
                Spacer()
            }.edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            .overlay(
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            irARecetas = true
                        }, label: {
                            Text("Recetas")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                        })
                        .padding(.trailing, 20)
                        .padding(.top, 5)
                        .background(NavigationLink("",
                                                 destination: RecetasView(irARecetas: $irARecetas), isActive: $irARecetas))
                        Spacer()
                    }
                }
            )
        }
    }
}

