//
//  NuevaRecetaView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 08/05/2021.
//

import SwiftUI
import Firebase


struct NuevaRecetaView: View {
    var irANuevaReceta: Binding<Bool>
    @State var irAAnadirIngredientes = false
    @ObservedObject var viewModel = RecetaViewModel()
    @State private var anadir: Bool = false
    @State private var anadirMas: Bool = false
    @State var ref: String
    @State private var duracion = ""
    @State private var raciones = ""
    // Alertas
    @State var alert = false
    @State var alertMensaje = ""

    
    var body: some View {

        VStack(alignment: .leading, spacing: 6){
            HStack {
                VStack (alignment: .leading){
                    Text("Nueva Receta")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                    
                }
                .accessibility(addTraits: .isHeader)
                Spacer()
            }

            Section(header: Text("Nombre")){
                SingleFormView(nombreCampo: "", valorCampo: $viewModel.receta.titulo)
            }
    
            Section(header: Text("Duración")){
                SingleFormView(nombreCampo: "", valorCampo: $duracion)
                    .keyboardType(.numberPad)
            }
            Section(header: Text("Raciones")){
                SingleFormView(nombreCampo: "", valorCampo: $raciones)
                    .keyboardType(.numberPad)
            }
            Section(){
                HStack {
                    Picker("Categoria 􀆈", selection: $viewModel.receta.categoria) {
                        ForEach(viewModel.categorias, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.black)
                    Spacer()
                    Text(viewModel.receta.categoria)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1).frame(height: 40))
                .padding(.vertical)
            }
            Button("Añadir ingredientes" ) {
                if viewModel.receta.titulo.isEmpty || duracion.isEmpty || raciones.isEmpty {
                    self.alertMensaje = "Debe rellenar todos los campos"
                    self.alert.toggle()
                    return
                }
                
                if Int(duracion) == nil || Int(raciones) == nil {
                    self.alertMensaje = "La duración y las raciones deben ser números"
                    self.alert.toggle()
                    return
                }
                
                if viewModel.receta.categoria == "" {
                    self.alertMensaje = "Debe seleccionar una categoría"
                    self.alert.toggle()
                    return
                }
                viewModel.receta.duracion = Int(duracion)!
                viewModel.receta.raciones = Int(raciones)!
                irAAnadirIngredientes = true
                self.ref = viewModel.anadirRecetas()
            }
            .background(
                NavigationLink("", destination: AnadirIngredientesView(receta: ref, irANuevaReceta: irANuevaReceta, irAAnadirIngredientes: $irAAnadirIngredientes), isActive: $irAAnadirIngredientes)
            )
            .buttonStyle(EstiloBoton())
            Spacer()
        }.padding(.horizontal)
        .padding()
        .navigationBarTitle("Receta", displayMode: .inline)
        .alert(isPresented: $alert, content: {
            Alert(title: Text("¡Importante!"), message: Text(alertMensaje), dismissButton: .cancel(Text("Aceptar")))
        })
    }
}
