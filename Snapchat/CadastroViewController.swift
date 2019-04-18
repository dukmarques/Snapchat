//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Eduardo on 18/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Method called whenever the user view the screen
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true) //Hides or displays navigation bar
    }
}
