//
//  DetallesReceta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct DetallesReceta: View {
    var refReceta = ""
    @ObservedObject private var viewModel = PasoViewModel()
    @State private var nuevoPaso = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.pasos) { paso in
                    HStack() {
                        Text(paso.descripcion)
                        Spacer()
                        if paso.duracion != 0{
                            Text("\(paso.duracion) min")
                        }
                    }
                }
            }.navigationBarTitle("Pasos")
            .onAppear() {
                self.viewModel.getPasos(ref: refReceta)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        nuevoPaso.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            
        }
        /*VStack {
            Image(imagen)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 220)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(titulo)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("| \(puntuacion)")
                            .font(.system(size: 18))
                    }
                    ForEach(viewModel.recetas){ receta in
                        Text(receta.titulo)
                        if receta.id == self.refReceta {
                            Text(receta.titulo)
                            List{
                                ForEach(viewModelPasos.pasos){ paso in
                                    Text(viewModelPasos.paso.descripcion)
                                }
                            }
                        }
                        
                    }
                }
                Spacer()
            }.padding(.horizontal)
            Spacer()
        }*/
        
    }
}

struct DetallesReceta_Previews: PreviewProvider {
    static var previews: some View {
        DetallesReceta(refReceta: "")
    }
}
