//
//  Datos.swift
//  BuscadorLibrosTablas
//
//  Created by Everardo Guevara Soto on 23/03/16.
//  Copyright © 2016 Everardo Guevara Soto. All rights reserved.
//

import Foundation
import UIKit

class Libro {
    var ISBN: String
    var titulo: String
    var autores: [String]
    var portada: UIImage?
    
    init() {
        ISBN = String()
        titulo = String()
        autores = [String]()
        portada = nil
    }
    
    init(ISBN: String, titulo: String, autores: [String], portada: UIImage?) {
        self.ISBN = ISBN
        self.titulo = titulo
        self.autores = autores
        self.portada = portada
    }
}