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
    @State private var cantidad = ""
    // Alertas
    @State var alert = false
    @State var alertMensaje = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                VStack (alignment: .leading){
                    Text("Añadir Ingredientes")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                    
                }
                .accessibility(addTraits: .isHeader)
                Spacer()
            }
            Section(header: Text("Nombre")) {
                SingleFormView(nombreCampo: "", valorCampo: $viewModel.ingrediente.nombre)
            }
            Section(header: Text("Cantidad")){
                SingleFormView(nombreCampo: "", valorCampo: $cantidad)
            }

            Section(){
                HStack {
                    Picker("Unidad >", selection: $viewModel.ingrediente.unidad) {
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
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                .padding(.bottom)
            }
            
            Button(action: {
                if viewModel.ingrediente.nombre.isEmpty || cantidad.isEmpty {
                    self.alertMensaje = "Debe rellenar al menos el nombre y la cantidad del ingrediente"
                    self.alert.toggle()
                    return
                }
                if Int(cantidad) == nil {
                    self.alertMensaje = "La cantidad debe ser un número"
                    self.alert.toggle()
                    return
                }
                viewModel.ingrediente.cantidad = Int(cantidad)!
                self.anadir = true
                viewModel.anadirIngrediente(ref: self.receta)
                viewModel.ingrediente.unidad = ""

            }, label: {
                HStack {
                    Spacer()
                    Text(anadir ? "Añadido" : "Añadir ingrediente")
                    Spacer()
                }
            })
            .foregroundColor(anadir ? .secondary : .orange)
            .buttonStyle(EstiloBotonSecundario())
            .disabled(anadir)
            Button(action: {
                self.anadirMas = true
                anadir = false
                viewModel.ingrediente.nombre = ""
                cantidad = ""
            }, label: {
                HStack {
                    Spacer()
                    Text("Añadir más ingredientes")
                    Spacer()
                }
            }).foregroundColor(.orange)
            .font(.title2)
            .buttonStyle(EstiloBotonSecundario())
            .foregroundColor(.white)
            Button(action: {
                if !anadir && !anadirMas {
                    self.alertMensaje = "Debe añadir al menos un ingrediente"
                    self.alert.toggle()
                    return
                }
                irAAnadirPasos = true
            }, label: {
                HStack {
                    Spacer()
                    Text("Siguiente paso")
                    Spacer()
                }
            }).buttonStyle(EstiloBoton())
            .background(
                NavigationLink("", destination: AnadirPasoView(receta: receta, irAAnadirIngredientes: $irAAnadirIngredientes), isActive: $irAAnadirPasos)
                    .hidden()
            )
            Spacer()
        }.padding(.horizontal)
        .padding()
        .navigationBarTitle("Ingredientes", displayMode: .inline)
        .alert(isPresented: $alert, content: {
            Alert(title: Text("¡Importante!"), message: Text(alertMensaje), dismissButton: .cancel(Text("Aceptar")))
        })
    }
}

