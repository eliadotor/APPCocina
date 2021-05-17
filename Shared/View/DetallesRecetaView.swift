//
//  DetallesReceta.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct DetallesRecetaView: View {
    var refReceta = ""
    @ObservedObject private var viewModelR = RecetaViewModel()
    @ObservedObject private var viewModel = PasoViewModel()
    @State private var imagen = ""
    @State private var nuevoPaso = false
    @State private var comenzarReceta = false
    
    var body: some View {
        VStack (alignment: .leading){
            Image("\(viewModelR.receta.foto )")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(viewModelR
                    .receta.titulo)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            HStack {
                Text("\(viewModelR.receta.duracion) min")
                    .font(.system(size: 18))
                Text("| ")
                    .font(.system(size: 18))
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                Text("\(viewModelR.receta.puntuacion) estrellas")
                    .font(.system(size: 18))
            }.padding(.horizontal)
            List{
                ForEach(viewModel.pasos) { paso in
                    HStack() {
                        Text(paso.descripcion)
                        Spacer()
                        if paso.duracion != 0{
                            Text("\(paso.duracion) min")
                                .foregroundColor(.yellow)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .onAppear() {
                self.viewModelR.getReceta(ref: refReceta)
                self.viewModel.getPasos(ref: refReceta)
            }
            Button(action: {
                comenzarReceta = true
            }, label: {
                HStack {
                    Spacer()
                    Text("Comenzar receta")
                    Spacer()
                }
            }).buttonStyle(EstiloBoton())
            .padding([.horizontal, .bottom])
            Spacer()
        }.edgesIgnoringSafeArea(.top)

    }
}

