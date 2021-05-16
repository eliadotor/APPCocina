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
    @State private var anadir: Bool = false
    @State private var anadirMas: Bool = false
    @State private var anadirIngredientes: Bool = false
    @State var ref: String
    
    var body: some View {

        NavigationView {
            VStack(alignment: .leading, spacing: 6){

                Section(header: Text("Nombre")){
                    TextField("", text: $viewModel.receta.titulo)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                        .padding(.bottom)
                    
                }
        
                Section(header: Text("Duración")){
                    TextField("Duración", value: $viewModel.receta.duracion, formatter: NumberFormatter()).keyboardType(.numberPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                        .padding(.bottom)
                }
                Section(header: Text("Raciones")){
                    TextField("Raciones", value: $viewModel.receta.raciones, formatter: NumberFormatter()).ignoresSafeArea(.keyboard)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                        .padding(.bottom)

                }
                Section(header: Text("Imagen")){
                    TextField("", text: $viewModel.receta.foto)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                        .padding(.bottom)

                }
                Section(){
                    HStack {
                        Picker("Categoria", selection: $viewModel.receta.categoria) {
                            ForEach(viewModel.categorias, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .foregroundColor(.yellow)
                        Spacer()
                        Text(viewModel.receta.categoria)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow, lineWidth: 1).frame(height: 40))
                    .padding(.bottom)

                }
                
                Button("Añadir ingredientes") {
                    anadirIngredientes = true
                    self.ref = viewModel.anadirRecetas()
                }.background(
                    NavigationLink("", destination: AnadirIngredientesView(receta: self.ref), isActive: $anadirIngredientes).hidden()
                )
                .buttonStyle(EstiloBoton())
                
            }.padding(.horizontal)
        }
    }
}

struct EstiloBoton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .font(.title2)
        .padding(.vertical)
        .foregroundColor(.white)
        .frame(height: 40)
        .background(Color.yellow)
        .cornerRadius(10)
}
}


struct NuevaRecetaView_Previews: PreviewProvider {
    static var previews: some View {
        NuevaRecetaView(ref: "")
    }
}

