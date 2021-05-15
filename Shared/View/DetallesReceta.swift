//
//  DetallesReceta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct DetallesReceta: View {
    var refReceta = ""
    @ObservedObject private var viewModel = RecetaViewModel()
    @ObservedObject private var viewModelPasos = PasoViewModel()

    var imagen : String
    var titulo : String
    var descripcion : String
    var puntuacion : String
    let pas = ["Pelar y cortar las patatas", "Freir las patatas", "Batir los huevos", "Escurrir las patatas y mezclarlas con el huevo", "Cuajar la mezcla en la sartén"]
    var body: some View {
        VStack {
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
        }
        
    }
}

struct DetallesReceta_Previews: PreviewProvider {
    static var previews: some View {
        DetallesReceta(imagen: "postre", titulo: "Tortilla de Patatas", descripcion: "Pasos", puntuacion: "5 Estrellas")
    }
}
