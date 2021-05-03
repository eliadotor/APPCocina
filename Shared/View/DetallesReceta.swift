//
//  DetallesReceta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct DetallesReceta: View {
    var imagen : String
    var titulo : String
    var descripcion : String
    var puntuacion : String
    let pasos = ["Pelar y cortar las patatas", "Freir las patatas", "Batir los huevos", "Escurrir las patatas y mezclarlas con el huevo", "Cuajar la mezcla en la sartén"]
    var body: some View {
        VStack {
            Image(imagen )
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
                            .font(.system(size: 22))
                    }
                    VStack (alignment: .leading){
                        Text(descripcion)
                        .font(.title2)
                            .padding(5)
                        List(pasos, id:\.self) {
                            Text("\($0)")
                                .font(.body)
                        }.padding(.leading, -10)
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
