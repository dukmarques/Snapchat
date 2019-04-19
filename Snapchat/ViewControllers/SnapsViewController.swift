//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Eduardo on 19/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            let alert = Alert(title: "Erro ao deslogar", message: "Ocorreu um erro, por favor, tente novamente.")
            present(alert.getAlert(), animated: true, completion: nil)
        }
    }
}
