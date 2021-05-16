//
//  DetallesPasos.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 16/05/2021.
//

import SwiftUI

struct DetallesPasosView: View {
    var refReceta = ""
    var irAAnadirPasos: Binding<Bool>
    @Binding var irAListaPasos: Bool
    @State var irAAnadirIngredientes = false
    @ObservedObject private var viewModel = PasoViewModel()
    @State private var nuevoPaso = false
    
    var body: some View {
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
        }.navigationBarTitle("Pasos", displayMode: .inline)
        .onAppear() {
            self.viewModel.getPasos(ref: refReceta)
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    irAAnadirPasos.wrappedValue = false
                    nuevoPaso.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $nuevoPaso) {
            AnadirPasoView(receta: refReceta, irAAnadirIngredientes: $irAAnadirIngredientes, irAAnadirPasos: irAAnadirPasos)
        }
            
        
    }
}

