//
//  Home.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct Home: View {
    var irHome: Binding<Bool>
    @State private var buscarReceta = ""
    @ObservedObject var viewModel = RecetaViewModel()
    @State private var refImagen = "gs://appcocina-5d597.appspot.com/recetas/receta.jpg"

    var body: some View {
        ScrollView() {
            VStack {
                HStack {
                    Image("TRACn")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180)
                        .accessibility(addTraits: .isHeader)
                    Spacer()
                }
            }.padding()
            TextField("Buscar recetas", text: $buscarReceta)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.headline)
                .padding([.horizontal, .top])
            BotonCrearReceta()
            Seccion(tituloSeccion: "Destacados", ref1: self.refImagen, ref2: self.refImagen)
            Seccion(tituloSeccion: "Recientes", ref1: self.refImagen, ref2: self.refImagen)
        }.navigationBarHidden(true)
        .onAppear() {
            viewModel.getRecetas()
        }
    }
}

struct BotonCrearReceta: View {
    @State var irANuevaReceta = false
    var body: some View {
        NavigationLink (destination: NuevaRecetaView(irANuevaReceta: $irANuevaReceta, ref: ""), isActive: $irANuevaReceta) {
            Button("Crear receta") {
                irANuevaReceta = true
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .font(.title)
            .foregroundColor(.white)
            .frame(height: 150)
            .background(Color.orange)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct Seccion: View {
    @State private var navegacion = false
    @State private var ref = "zbwTGYYQH4Anp3KFn4tk"
    var tituloSeccion  = ""
    var ref1 = ""
    var ref2 = ""
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    Text(tituloSeccion)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                }.padding(.horizontal)
                .accessibility(addTraits: .isHeader)
                Spacer()
            }
            HStack {
                NavigationLink(destination: DetallesRecetaView(refReceta: ref, crear: false)){
                    VStack(alignment: .leading) {
                        ImagenHomeStorage(imagenUrl: ref1)
                    }.padding(.horizontal,2)
                }
                NavigationLink(destination: DetallesRecetaView(refReceta: ref, crear: false)){
                    VStack(alignment: .leading) {
                        ImagenHomeStorage(imagenUrl: ref1)
                    }.padding(.horizontal,2)
                }
            }.padding()
        }
    }
}


