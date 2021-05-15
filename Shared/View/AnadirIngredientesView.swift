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
            Form {
                Section(header: Text("Ingrediente")) {
                    TextField("", text: $viewModel.ingrediente.nombre)
                        .disabled(anadir ? true : false)
                    TextField("Cantidad", value: $viewModel.ingrediente.cantidad, formatter: NumberFormatter())
                        .disabled(anadir ? true : false)
                    HStack {
                        Picker("Unidad", selection: $medidasOpcionTag) {
                            Text("gramos").tag(0)
                            Text("litros").tag(1)
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(medidas[medidasOpcionTag])
                    }
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
                }).disabled(anadir)
                
                Button(action: {
                    self.anadirMas = true
                    anadir = false
                }, label: {
                    HStack {
                        Spacer()
                        Text("Añadir más ingredientes")
                        Spacer()
                    }
                })
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
            }.navigationBarTitle("Ingredientes", displayMode: .inline)
            
            
        }
    }
}

struct AnadirIngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        AnadirIngredientesView(receta: "")
    }
}
