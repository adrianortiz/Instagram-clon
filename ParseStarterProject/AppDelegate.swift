//
//  AppDelegate.swift
//
//  Copyright 2015 Codizer. All rights reserved.
//

import UIKit
import Parse


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------

    // Se ejecuta cuando la aplicación acaba de arrancar
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        // De está forma se podra acceder a Parse desde cualquier controler, vista, etc.
        Parse.setApplicationId("RjlU3Cw7infV8nTg9GmcuYmdfv0JbUfZVaSJY2OY", clientKey: "St7vDpuUhUjx2TGCk9nENwfrFtNkOaE668g6e0Uo")
        
        return true
    }

  }
