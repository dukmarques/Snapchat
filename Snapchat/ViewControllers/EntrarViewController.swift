//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Eduardo on 18/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Method called whenever the user view the screen
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true) //Hides or displays navigation bar
    }
    
    @IBAction func logIn(_ sender: Any) {
        //Recover typed data
        if let emailR = self.email.text {
            if let pass = self.password.text {
                //Authenticate user on firebase
                let auth = Auth.auth()
                auth.signIn(withEmail: emailR, password: pass) { (user, error) in
                    if error == nil {
                        if user == nil {
                            self.viewMessage(title: "Erro ao autenticar", message: "Problema ao realizar autenticação, tente novamente.")
                        } else {
                            //Redirects user to main screen
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    } else {
                        self.viewMessage(title: "Dados incorretos", message: "Verifique os dados digitados")
                    }
                }
            }
        }
    }
    
    //Displayed alert to user
    func viewMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
