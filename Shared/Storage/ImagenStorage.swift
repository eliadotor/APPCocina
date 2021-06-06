//
//  ImagenFirebaseView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 27/05/2021.
//

import SwiftUI
import UIKit


let imagenAlternativa = UIImage(systemName: "qrcode.viewfinder")
struct ImagenStorage: View {
    @ObservedObject var imagenLoader: Loader
    
    init(imagenUrl: String) {
        self.imagenLoader = Loader(imagenUrl: imagenUrl)
    }
    
    var imagen: UIImage? {
        self.imagenLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: imagen ?? imagenAlternativa!)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct ImagenListaStorage: View {
    @ObservedObject var imagenLoader: Loader
    
    init(imagenUrl: String) {
        self.imagenLoader = Loader(imagenUrl: imagenUrl)
    }
    
    var imagen: UIImage? {
        self.imagenLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        if imagen != nil {
            Image(uiImage: imagen!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(12)
        }
    }
}

struct ImagenRecetaStorage: View {
    @ObservedObject var imagenLoader: Loader
    
    init(imagenUrl: String) {
        self.imagenLoader = Loader(imagenUrl: imagenUrl)
    }
    
    var imagen: UIImage? {
        self.imagenLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        if imagen != nil {
            Image(uiImage: imagen!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct ImagenRecetasStorage: View {
    @ObservedObject var imagenLoader: Loader
    
    init(imagenUrl: String) {
        self.imagenLoader = Loader(imagenUrl: imagenUrl)
    }
    
    var imagen: UIImage? {
        self.imagenLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        if imagen != nil {
            Image(uiImage: imagen!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160, alignment: .center)
                .clipped()
                .cornerRadius(12)
        }
    }
}

struct ImagenHomeStorage: View {
    @ObservedObject var imagenLoader: Loader
    
    init(imagenUrl: String) {
        self.imagenLoader = Loader(imagenUrl: imagenUrl)
    }
    
    var imagen: UIImage? {
        self.imagenLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        if imagen != nil {
            Image(uiImage: imagen!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .clipped()
                .cornerRadius(12)
        } else {
            Text("Cargando imagen...")
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct ImagenCuentaStorage: View {
    @ObservedObject var imagenLoader: Loader
    
    init(imagenUrl: String) {
        self.imagenLoader = Loader(imagenUrl: imagenUrl)
    }
    
    var imagen: UIImage? {
        self.imagenLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        if imagen != nil {
            Image(uiImage: imagen!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(50)
        } else {
            Text("Cargando imagen...")
                .foregroundColor(.white)
                .padding()
        }
    }
}
