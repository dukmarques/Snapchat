//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Eduardo on 18/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Method called whenever the user view the screen
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true) //Hides or displays navigation bar
    }
    
    @IBAction func createAccount(_ sender: Any) {
        //Recover typed data
        if let emailR = self.email.text {
            if let passwordR = self.password.text {
                if let confirmR = self.confirm.text {
                    
                    //Validate password
                    if passwordR == confirmR {
                        //Create firebase account
                        let auth = Auth.auth()
                        auth.createUser(withEmail: emailR, password: passwordR) { (user, error) in
                            if error == nil{
                                if user == nil {
                                    self.viewMessage(title: "Erro ao autenticar", message: "Problema ao realizar autenticação, tente novamente.")
                                } else {
                                    //Redirects user to main screen
                                    self.performSegue(withIdentifier: "registerLoginSegue", sender: nil)
                                }
                            } else {
                                let err = error! as NSError
                                if let codError = err.userInfo["error_name"] {//Recover the typed error
                                    let textError = codError as! String
                                    var errorMessage = ""
                                    
                                    //Check which error ocurred
                                    switch textError {
                                        case "ERROR_INVALID_EMAIL":
                                            errorMessage = "E-mail inválido, digite um e-mail válido!"
                                        break
                                        case "ERROR_WEAK_PASSWORD":
                                            errorMessage = "Senha precisa conter no mínimo 6 caracteres com letras e números."
                                        break
                                        case "ERROR_EMAIL_ALREADY_IN_USE" :
                                            errorMessage = "Este e-mail já foi cadastrado!"
                                        break
                                    default:
                                        errorMessage = "Dados digitados estão incorretos."
                                    }
                                    
                                    //Display alert
                                    self.viewMessage(title: "Dados inválidos", message: errorMessage)
                                }
                            }
                        }
                    } else {
                        self.viewMessage(title: "Senhas distintas", message: "As senhas não são iguais, digite novamente")
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
