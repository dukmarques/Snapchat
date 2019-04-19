//
//  ViewController.swift
//  Snapchat
//
//  Created by Eduardo on 13/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if a user already exists
        let auth = Auth.auth()
        auth.addStateDidChangeListener { (auth, user) in
            if let userLogged = user {
                self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
            }
        }
    }
    
    //Method called whenever the user view the screen
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false) //Hides or displays navigation bar
    }
}
