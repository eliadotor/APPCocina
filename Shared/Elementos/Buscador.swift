//
//  SwiftUIView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 9/6/21.
//


import SwiftUI
 
struct SearchBar: View {
    @Binding var texto: String
    @State private var editando = false
 
    var body: some View {
        HStack {
            TextField("Buscar...", text: $texto)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if editando {
                            Button(action: {
                                self.texto = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.editando = true
                }
 
            if editando {
                Button(action: {
                    self.editando = false
                    self.texto = ""
                }) {
                    Text("Cancelar")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
