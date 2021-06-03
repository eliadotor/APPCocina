//
//  RecetasView.swift
//  APPCocina
//
//  Created by Elia Dotor Puente on 21/05/2021.
//

import SwiftUI

struct RecetasView: View {
    @EnvironmentObject var viewModel: RecetaViewModel
    @State var refReceta = ""
    @State var imagen = UIImage()
    @State private var nuevaReceta = false
    var irARecetas: Binding<Bool>
    @State private var buscarReceta = ""
    
    var columnas: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack {
            ScrollView([ .vertical ], showsIndicators: false){
                HStack {
                    VStack (alignment: .leading){
                        Text("Recetas")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.top)
                        
                    }.padding(.vertical)
                    .padding(.leading, 21)
                    .accessibility(addTraits: .isHeader)
                    Spacer()
                }
                SingleFormView(nombreCampo: "Buscar recetas", valorCampo: $buscarReceta, protegido: false)
                    .padding(.horizontal, 21)
                LazyVGrid(columns: columnas, alignment: .center, spacing: 18) {
                    ForEach(viewModel.recetas) { receta in
                        NavigationLink(destination: DetallesRecetaView(refReceta: receta.id!, crear: false)){
                            VStack(alignment: .leading) {
                                ImagenRecetasStorage(imagenUrl: receta.foto)
                            }.padding(.horizontal,2)
                        }
                    }
                }.padding()
            }.navigationBarHidden(true)
            .onAppear() {
                self.viewModel.getRecetas()
            }
        }
    }
}

struct MisRecetasView: View {
    @EnvironmentObject var viewModel: RecetaViewModel
    @State var irANuevaReceta = false

    var body: some View {
        VStack{
            List() {
                ForEach(viewModel.recetas) { receta in
                    NavigationLink(destination: DetallesRecetaView(refReceta: receta.id!, crear: false)){
                        VStack(alignment: .leading) {
                            HStack{
                                ImagenListaStorage(imagenUrl: receta.foto)
                                Text(receta.titulo).font(.title)
                            }
                        }
                    }
                }.onDelete { (index) in
                    let id = self.viewModel.recetas[index.first!].id
                    self.viewModel.eliminar(id: id!)
                    self.viewModel.recetas.remove(atOffsets: index)
                }
            }
        }.navigationBarTitle("Mis Recetas", displayMode: .inline)
        .onAppear() {
            self.viewModel.getMisRecetas()
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarTrailing){
                Button(action: {
                    irANuevaReceta = true
                }, label: {
                    Label("Nueva receta", systemImage: "plus")
                })
            }
        }
    }
}
