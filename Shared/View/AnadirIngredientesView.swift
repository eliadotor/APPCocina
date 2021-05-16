//
//  AnadirIngredientesView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 09/05/2021.
//

import SwiftUI
import Firebase

struct AnadirIngredientesView: View {
    var receta: String
    @StateObject var viewModel = IngredienteViewModel()
    @State private var medidasOpcionTag: Int = 0
    var medidas = ["gramos", "litros"]
    @State private var anadir: Bool = false
    @State private var anadirMas: Bool = false
    @State private var siguientePaso: Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 6) {
                Section(header: Text("Nombre")) {
                    TextField("", text: $viewModel.ingrediente.nombre)
                        .disabled(anadir ? true : false)
                    padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                    .padding(.bottom)
                }
        
                Section(header: Text("Cantidad")){
                    TextField("", value: $viewModel.ingrediente.cantidad, formatter: NumberFormatter())
                        .disabled(anadir ? true : false)
                    padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                    .padding(.bottom)
                }
        
                Section(){
                    HStack {
                        Picker("Unidad", selection: $viewModel.ingrediente.unidad) {
                            ForEach(viewModel.medidas, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        Spacer()
                        Text(viewModel.ingrediente.unidad)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                    .padding(.bottom)
                }
                
                Button(action: {
                    self.anadir = true
                    viewModel.anadirIngrediente(ref: self.receta)
                }, label: {
                    HStack {
                        Spacer()
                        Text(anadir ? "Añadido" : "Añadir ingrediente")
                        Spacer()
                    }
                }).buttonStyle(EstiloBoton())
                .disabled(anadir)
                
                Button(action: {
                    self.anadirMas = true
                    anadir = false
                }, label: {
                    HStack {
                        Spacer()
                        Text("Añadir más ingredientes")
                        Spacer()
                    }
                }).buttonStyle(EstiloBoton())
                Button(action: {
                    self.siguientePaso = true
                }, label: {
                    HStack {
                        Spacer()
                        Text("Siguiente paso")
                        Spacer()
                    }
                }).background(
                    NavigationLink("", destination: AnadirPasoView(receta: receta), isActive: $siguientePaso).hidden())
                .buttonStyle(EstiloBoton())
            }.padding(.horizontal)
            .navigationBarTitle("Ingredientes", displayMode: .inline)
            
            
        }
    }
}

struct AnadirIngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        AnadirIngredientesView(receta: "")
    }
}
