//
//  DetallesPasos.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 16/05/2021.
//

import SwiftUI

struct DetallesPasosView: View {
    var refReceta = ""
    @ObservedObject private var viewModel = PasoViewModel()
    @State private var nuevoPaso = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.pasos) { paso in
                    VStack(alignment: .leading) {
                        Text(paso.descripcion).font(.title)
                        //Text(paso.duracion).font(.subheadline)
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
            .sheet(isPresented: $nuevoPaso) {
                AnadirPasoView(receta: refReceta)
            }
            
        }
    }
}

struct DetallesPasosView_Previews: PreviewProvider {
    static var previews: some View {
        DetallesPasosView(refReceta: "")
    }
}
