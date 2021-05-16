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
    var irANuevaReceta: Binding<Bool>
    @Binding var irAAnadirIngredientes: Bool
    @State var irAAnadirPasos = false
    @StateObject var viewModel = IngredienteViewModel()
    @State private var anadir: Bool = false
    @State private var anadirMas: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Section(header: Text("Nombre")) {
                TextField("", text: $viewModel.ingrediente.nombre)
                .disabled(anadir ? true : false)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                .padding(.bottom)
            }
    
            Section(header: Text("Cantidad")){
                TextField("", value: $viewModel.ingrediente.cantidad, formatter: NumberFormatter())
                    //.disabled(anadir ? true : false)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                .padding(.bottom)
            }
    
            Section(){
                HStack {
                    Picker("Unidad  >", selection: $viewModel.ingrediente.unidad) {
                        ForEach(viewModel.medidas, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.black)
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
            }).foregroundColor(.yellow)
            .font(.title2)
            .buttonStyle(EstiloBoton())
            .padding(.bottom)
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
            }).foregroundColor(.yellow)
            .font(.title2)
            .buttonStyle(EstiloBoton())
            .padding(.bottom)
            Button(action: {
                irAAnadirPasos = true
            }, label: {
                HStack {
                    Spacer()
                    Text("Siguiente paso")
                    Spacer()
                }
            }).buttonStyle(EstiloBoton())
            .buttonStyle(EstiloBoton())
            .background(
                NavigationLink("", destination: AnadirPasoView(receta: receta, irAAnadirIngredientes: $irAAnadirIngredientes, irAAnadirPasos: $irAAnadirPasos), isActive: $irAAnadirPasos)
                    .hidden()
            )
            Spacer()
        }.padding()
        .navigationBarTitle("Ingredientes", displayMode: .inline)
        .navigationBarItems(leading: NuevaRecetaView(irANuevaReceta: irANuevaReceta, ref: receta))
    }
}

