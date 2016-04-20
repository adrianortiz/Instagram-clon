//
//  ViewController.swift
//
//  Copyright 2015 Codizer. All rights reserved.
//

import UIKit
import Parse

// Implementar delegados
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // Imagen seleccionada
    @IBOutlet weak var pickedImage: UIImageView!
    
    // Evento del button
    @IBAction func pickImage(sender: AnyObject) {
        
        let imagePC = UIImagePickerController()
        // delegado que va a informar, es este propio view controller self
        imagePC.delegate = self
        // De donde obntedrá las fotos fotos del usuario
        imagePC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // Evitar que puede editar las fotos
        imagePC.allowsEditing = false
        
        // Mostrar al usuario el view controller de fotos
        self.presentViewController(imagePC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
        // CLAVE DE PARSE
        Parse.setApplicationId("RjlU3Cw7infV8nTg9GmcuYmdfv0JbUfZVaSJY2OY", clientKey: "St7vDpuUhUjx2TGCk9nENwfrFtNkOaE668g6e0Uo")
        */
        
        /*
        // Crer una clase llamada score, para después crear instancias en let
        let score = PFObject(className: "score")
        
        // valores de nuestro objeto score
        score.setObject("Adrian", forKey: "name")
        score.setObject(95, forKey: "number")
        
        // Guardar objeto en cloud
        score.saveInBackgroundWithBlock { (success, error) -> Void in
            // Saber si se guardo correctamente
            if success {
                print("El objeto score ha sido creado con identificador \(score.objectId)")
            }
            else {
                print(error)
            }
        }
         */
        
        /*
        
        // REALIZAR UN CRUD
        let query = PFQuery(className: "score")
        
        // mediante el id en parse
        query.getObjectInBackgroundWithId("oOSHCHY8vQ", block: { (score:PFObject?, error:NSError?) -> Void in
            if error == nil {
         
                // CONSULTAR
                
                // print(score!)
                // Recuperar campo por key
                //print(score!.objectForKey("name")!)
                
                // Acceder como un diccionario (es lo mismo)
                // print(score!["name"]!)
                
                // ACTUALIZAR
                score!["name"] = "Alejandro"
                score!["number"] = 5
                
                // Puedes añadir nuevos campos
                // score!["apellido"] = "Ortiz"
                
                score?.saveInBackgroundWithBlock({ (success, error) in
                    if success {
                        print("El objeto ha sido actulizado")
                    } else {
                        print(error)
                    }
                })
                
            } else {
                print(error)
            }
        })
         */
        
        
        // ALAM
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

