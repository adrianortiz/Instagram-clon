//
//  ViewController.swift
//
//  Copyright 2015 Codizer. All rights reserved.
//

import UIKit
import Parse

// Implementar delegados
class ViewController: UIViewController { //, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    /*
    // Imagen seleccionada
    @IBOutlet weak var pickedImage: UIImageView!
    
    let loading = UIActivityIndicatorView()
    
    // Action del button Pause
    @IBAction func pause(sender: AnyObject) {
        // Mostrar un loading
        
        loading.center = self.view.center
        loading.hidesWhenStopped = true
        loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loading.startAnimating()
        
        // Añadir a la vista
        self.view.addSubview(loading)
        
        // Evitar que se pulsen otros botones
        // UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    // Action button Reanudar
    @IBAction func restart(sender: AnyObject) {
        self.loading.stopAnimating()
        // UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    // Action button Crear Alerta
    @IBAction func createAlert(sender: AnyObject) {
        let alert = UIAlertController(title: "Un momento", message: "Estás seguro de continuar?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // Agregar button al alert
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Action del button Elegir foto
    @IBAction func pickImage(sender: AnyObject) {
        
        let imagePC = UIImagePickerController()
        // delegado que va a informar, es este propio view controller self
        imagePC.delegate = self
        // De donde obntedrá las fotos fotos del usuario
        imagePC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary // .Camera
        // Evitar que puede editar las fotos
        imagePC.allowsEditing = false
        
        // Mostrar al usuario el view controller de fotos
        self.presentViewController(imagePC, animated: true, completion: nil)
        
    }
    
    // Identificar cuando un usuario ha elegido una foto
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("El usuario ha elegido una foto")
        
        // Mostrar la foto seleccionada
        self.pickedImage.image = image
        
        // Desactivar modal
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
 */
    
    let loading = UIActivityIndicatorView()
    var signUpActive = true
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signUpToggleButton: UIButton!
    @IBOutlet weak var alreadyRegistered: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        var error = ""
        
        if self.username.text == "" || self.password.text == "" {
            error = "Por favor, introduce un usuario y contraseña"
            
        } else {
            
            // loading
            loading.center = self.view.center
            loading.hidesWhenStopped = true
            loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loading.startAnimating()
            
            self.view.addSubview(loading)
            
            // Desactivar eventos en la vista
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signUpActive {
                
                // Registrar
                let user = PFUser()
                user.username = self.username.text
                user.password = self.password.text
                
                user.signUpInBackgroundWithBlock({ (succeed: Bool, signUpError: NSError?) in
                    
                    // Activar eventos en la vista
                    self.loading.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signUpError == nil {
                        print("Usuario registrado")
                    } else {
                        if let errorString = signUpError!.userInfo["error"] as? NSString {
                            self.displayAlert("Error al registrar", message: String(errorString))
                        } else {
                            self.displayAlert("Error al registrar", message: "Por favor reinténtalo")
                        }
                    }
                    
                })
            }
            else {
                // Iniciar sesión
                PFUser.logInWithUsernameInBackground(self.username.text!, password:self.password.text!) {
                    (user: PFUser?, loginError: NSError?) -> Void in
                    
                    // Activar eventos en la vista
                    self.loading.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        print("El usuario ha podido acceder!")
                    } else {
                        if let errorString = loginError!.userInfo["error"] as? NSString {
                            self.displayAlert("Error al acceder", message: String(errorString))
                        } else {
                            self.displayAlert("Error al acceder", message: "Por favor reinténtalo")
                        }
                    }
                }
            }
            
        }
        
        if error != "" {
            self.displayAlert("Error en el formulario", message: error)
        }
    }
    
    
    @IBAction func signUpToggle(sender: AnyObject) {
        if signUpActive {
            // Estoy en modo registro, voy a modo acceso
            self.signUpToggleButton.setTitle("Registrarse", forState: .Normal)
            self.alreadyRegistered.text = "¿Aún no registrado?"
            self.signUpButton.setTitle("Acceder", forState: .Normal)
            self.signUpLabel.text = "Usa el formulario inferiror para acceder"
            
            signUpActive = false
            
        } else {
            // Estoy en modo acceso, voy a cambiar a modo registro
            self.signUpToggleButton.setTitle("Acceder", forState: .Normal)
            self.alreadyRegistered.text = "¿Ya registrado?"
            self.signUpButton.setTitle("Registrar nuevo usuario", forState: .Normal)
            self.signUpLabel.text = "Usa el formulario inferiror para registrarte"
            
            signUpActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Saber el usuario que esta logueado
        // print(PFUser.currentUser())
    }

    // Se recomianda realizar las animaciónes de las pantallas aqui
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("jumpToUsersTable", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

