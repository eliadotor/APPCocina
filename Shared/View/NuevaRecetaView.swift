//
//  NuevaRecetaView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 08/05/2021.
//

import SwiftUI
import Firebase


struct NuevaRecetaView: View {
    @ObservedObject var viewModel = RecetaViewModel()
    @State private var categoriaOpcion: Int = 0
    @State private var anadir: Bool = false
    @State private var anadirMas: Bool = false
    @State private var anadirIngredientes: Bool = false
    @State var ref: String

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Receta")){
                    TextField("Nombre", text: $viewModel.receta.titulo)
                    TextField("Duración", value: $viewModel.receta.duracion, formatter: NumberFormatter()).keyboardType(.numberPad)
                    TextField("Raciones", value: $viewModel.receta.raciones, formatter: NumberFormatter()).ignoresSafeArea(.keyboard)
                    TextField("Imagen", text: $viewModel.receta.foto)
                    HStack {
                        Picker("Categoria", selection: $categoriaOpcion) {
                            Text(viewModel.categorias[0]).tag(0)
                            Text(viewModel.categorias[1]).tag(1)
                            Text(viewModel.categorias[2]).tag(2)
                            Text(viewModel.categorias[3]).tag(3)
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(viewModel.categorias[categoriaOpcion])
                    }
                }

                Button("Añadir ingredientes" ) {
                    anadirIngredientes = true
                    self.ref = viewModel.anadirRecetas()
                }.background(
                    NavigationLink("", destination: AnadirIngredientesView(receta: self.ref), isActive: $anadirIngredientes).hidden()
                )
            }.navigationBarTitle("Nueva Receta", displayMode: .inline)
        }
    }
}


struct NuevaRecetaView_Previews: PreviewProvider {
    static var previews: some View {
        NuevaRecetaView(ref: "")
    }
}
