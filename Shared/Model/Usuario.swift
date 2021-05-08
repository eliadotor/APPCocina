//
//  Usuario.swift
//  cocina
//
//  Created by Elia Dotor Puente on 06/05/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Usuario: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var email: String
    var nick: String
    var pass: String
    var foto: String
    
    enum codingKey: String, CodingKey {
        case email
        case nick
        case pass = "password"
        case foto
    }
}
