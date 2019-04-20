//
//  UsersTableViewController.swift
//  Snapchat
//
//  Created by Eduardo on 20/04/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsersTableViewController: UITableViewController {
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let database = Database.database().reference()
        let usersRef = database.child("usuarios")
        
        //Add new user added event
        usersRef.observe(DataEventType.childAdded) { (snapshot) in
            let data = snapshot.value as? NSDictionary
            
            //Recover data
            let userEmail = data?["email"] as! String
            let userName = data?["name"] as! String
            let userId = snapshot.key
            
            //Add array
            let user = User(email: userEmail, name: userName, uid: userId)
            self.users.append(user)
            
            self.tableView.reloadData() //Reload list
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //Config cell
        cell.textLabel?.text = self.users[indexPath.row].name
        
        return cell
    }
}
