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
            .cornerRadius(12)
            .aspectRatio(contentMode: .fill)
    }
}

