//
//  DetalleLibro.swift
//  BuscadorLibrosTablas
//
//  Created by Everardo Guevara Soto on 23/03/16.
//  Copyright © 2016 Everardo Guevara Soto. All rights reserved.
//

import UIKit

class DetalleLibro: UIViewController {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UITextView!
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var ISBN: UITextField!
    @IBOutlet weak var btnAgregarLibro: UIButton!
    
    var libro: Libro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if libro != nil {
            titulo.text = libro?.titulo
            var listaAutores = ""
            
            for autor in (libro?.autores)! {
                listaAutores += "- \(autor)\n"
            }
            
            autores.text = listaAutores
            portada.image = libro?.portada
            ISBN.text = libro?.ISBN
            ISBN.enabled = false
            btnAgregarLibro.hidden = true
        } else {
            limpiarVista()
            ISBN.enabled = true
            btnAgregarLibro.hidden = false
        }
    }
    
    @IBAction func buscarLibro() {
        let url = NSURL(string: "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(ISBN.text!)")
        
        if let datos = NSData(contentsOfURL: url!) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos, options: NSJSONReadingOptions.MutableLeaves)
                let dicJson = json as! NSDictionary
                
                if let dicISBN = dicJson["ISBN:\(ISBN.text!)"] as! NSDictionary! {
                    libro = Libro()
                    libro!.ISBN = ISBN.text!
                    libro!.titulo = dicISBN["title"] as! NSString as String
                    titulo.text = libro!.titulo
                    
                    if let dicCover = dicISBN["cover"] as! NSDictionary! {
                        if let url  = NSURL(string: dicCover["medium"] as! NSString as String), data = NSData(contentsOfURL: url) {
                            libro!.portada = UIImage(data: data)
                        }
                    }
                    
                    portada.image = libro!.portada
                    let dicAutores = dicISBN["authors"] as! NSArray
                    var listaAutores = ""
                    
                    for i in 0 ..< dicAutores.count {
                        libro!.autores.append(dicAutores[i]["name"] as! String)
                        listaAutores += "- \(libro!.autores[i])\n"
                    }
                    
                    autores.text = listaAutores
                } else {
                    limpiarVista()
                    mostrarAlerta("No se encontro ISBN")
                }
            } catch _ {
                limpiarVista()
                mostrarAlerta("Ocurrió un error al obtener la información")
            }
        } else {
            limpiarVista()
            mostrarAlerta("Error de conexión")
        }
    }
    
    func limpiarVista() {
        titulo.text = nil
        autores.text = nil
        portada.image = nil
        ISBN.text = nil
    }
    
    func mostrarAlerta(mensaje: String) {
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func agregarLibro() {
        self.performSegueWithIdentifier("unwind", sender: self)
    }
    
}
