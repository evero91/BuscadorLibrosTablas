//
//  TablaLibros.swift
//  BuscadorLibrosTablas
//
//  Created by Everardo Guevara Soto on 23/03/16.
//  Copyright © 2016 Everardo Guevara Soto. All rights reserved.
//

import UIKit

class TablaLibros: UITableViewController {
    
    var libros = [Libro]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.libros.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellLibro", forIndexPath: indexPath)
        cell.textLabel?.text = self.libros[indexPath.row].titulo
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controlDetalleLibro = segue.destinationViewController as! DetalleLibro
        
        switch segue.identifier! {
        case "buscarLibro":
            controlDetalleLibro.libro = nil
        case "mostrarDetalle":
            controlDetalleLibro.libro = self.libros[self.tableView.indexPathForSelectedRow!.row]
        default:
            print("segue sin preparar")
        }
    }
    
    @IBAction func unwindDetalleLibro (segue : UIStoryboardSegue) {
        if let source = segue.sourceViewController as? DetalleLibro {
            if let libro = source.libro {
                for l in libros {
                    if libro.ISBN == l.ISBN {
                        return
                    }
                }
                libros.append(libro)
                self.tableView.reloadData()
            }
        }
    }

}
