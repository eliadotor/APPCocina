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
    @State private var alturaVista : CGFloat = 0
    
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
                        
                    }.padding(.top)
                    .padding(.leading, 18)
                    .accessibility(addTraits: .isHeader)
                    Spacer()
                }
                VStack {
                    SearchBar(texto: self.$buscarReceta)
                        .padding(.bottom)
                    LazyVGrid(columns: columnas, alignment: .center, spacing: 18) {
                        ForEach(viewModel.recetas.filter {
                            self.buscarReceta.lowercased().isEmpty ? true :
                            $0.titulo.lowercased().contains(self.buscarReceta.lowercased())
                        }) { receta in
                            NavigationLink(destination: DetallesRecetaView(refReceta: receta.id!, crear: false)){
                                ImagenRecetasStorage(imagenUrl: receta.foto)
                                    .accessibilityLabel(receta.titulo)
                                    .padding(.horizontal,2)
                            }
                        }
                    }.padding(.horizontal, 8)
                }.padding(.horizontal, 8)
                .padding(.vertical, 8)
                .offset(y: -self.alturaVista)
                .animation(.spring())
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
    @State private var buscarReceta = ""


    var body: some View {
        VStack{
            SearchBar(texto: self.$buscarReceta)
                .padding(.vertical, 20)
                .padding(.horizontal, 6)
            List() {
                ForEach(viewModel.recetas.filter {
                    self.buscarReceta.lowercased().isEmpty ? true :
                    $0.titulo.lowercased().contains(self.buscarReceta.lowercased())
                }) { receta in
                    NavigationLink(destination: DetallesRecetaView(refReceta: receta.id!, crear: false)){
                        HStack{
                            ImagenListaStorage(imagenUrl: receta.foto)
                            Text(receta.titulo).font(.title)
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
