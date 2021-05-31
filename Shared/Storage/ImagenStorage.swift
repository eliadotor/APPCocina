//
//  ImagenFirebaseView.swift
//  APPCocina (iOS)
//
//  Created by Elia Dotor Puente on 27/05/2021.
//

import SwiftUI
import UIKit


let imagenAlternativa = UIImage(systemName: "qrcode.viewfinder")
let imagenAlter = UIImage(systemName: "doc.text")


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
        Image(uiImage: imagen ?? imagenAlter!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .clipped()
            .cornerRadius(12)
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
        Image(uiImage: imagen ?? imagenAlter!)
            .resizable()
            .aspectRatio(contentMode: .fit)
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
        Image(uiImage: imagen ?? imagenAlter!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150, alignment: .center)
            .clipped()
            .cornerRadius(12)
    }
}

