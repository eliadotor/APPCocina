//
//  EstiloBotonView.swift
//  cocina
//
//  Created by Elia Dotor Puente on 20/05/2021.
//

import SwiftUI

struct EstiloBotonCrearReceta: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
        .frame(height: 120)
        .background(Color.yellow)
        .cornerRadius(12)
    }
}

struct EstiloBoton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .font(.title2)
        .foregroundColor(.white)
        .frame(height: 45)
        .background(Color.orange)
        .cornerRadius(10)
        .padding()
    }
}

struct EstiloBotonSecundario: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .font(.title2)
        .frame(height: 45)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 2).frame(height: 45))
        .padding(.horizontal)
        .padding(.top)
    }
}

struct EstiloBotonLogin: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .font(.title2)
        .foregroundColor(.white)
        .frame(height: 45)
        .background(Color.orange)
        .cornerRadius(10)
        .padding()
    }
}


struct EstiloBotonLoginApple: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .font(.title2)
        .foregroundColor(.white)
        .frame(height: 45)
        .background(Color.black)
        .cornerRadius(10)
        .padding()
    }
}

