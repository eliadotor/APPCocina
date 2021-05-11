//
//  Home.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 03/05/2021.
//

import SwiftUI

struct Home: View {
    @State private var buscarReceta = ""
    var body: some View {
        NavigationView {
            ScrollView() {
                TextField("Buscar recetas", text: $buscarReceta)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.headline)
                    .padding()
                BotonCrearReceta()
                Seccion(tituloSeccion: "Destacados")
                Seccion(tituloSeccion: "Recientes")
            }
            .navigationBarTitle("APP Cocina")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct EstiloBotonCrear: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
        .frame(height: 120)
        .background(Color.yellow)
        .cornerRadius(12)
    }
}

struct BotonCrearReceta: View {
    @State var mostrarCreador = false
    var body: some View {
        NavigationLink (destination: CreadorReceta(), isActive: $mostrarCreador) {
            EmptyView()
        }
        .hidden()
        Button("Crear receta") {
            mostrarCreador = true
        }
        .font(.title)
        .foregroundColor(.white)
        .frame(height: 150)
        .background(Color.yellow)
        .cornerRadius(10)
        .padding()
        }
    }

struct Imagenes: View {
    
    @Binding var navegacion : Bool

    var body: some View {
        Button (action: {
            navegacion = true
        }) {
            Image("cocina")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(12)
            
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .cornerRadius(12)
        .background(
    NavigationLink("",
                                   destination: DetallesReceta(imagen: "postre", titulo: "Tortilla de Patatas", descripcion: "Pasos", puntuacion: "5 Estrellas"),
                                   isActive: $navegacion)
        .hidden()
        )
    }
}

struct Seccion: View {
    @State private var navegacion = false

    var tituloSeccion  = ""
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
                Imagenes(navegacion: $navegacion)
                    .padding(.trailing, .init(4))
                Imagenes(navegacion: $navegacion)
                    .padding(.leading, .init(4))
            }.padding()
        }
    }
}


