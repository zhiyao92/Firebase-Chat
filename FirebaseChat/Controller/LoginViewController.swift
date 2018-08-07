//
//  LoginViewController.swift
//  FirebaseChat
//
//  Created by Kelvin Tan on 8/3/18.
//  Copyright © 2018 Kelvin Tan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Missing Information", message: "Please insert your name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "toChat", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat" {
            if let destination = segue.destination as? ViewController {
                destination.name = nameTextField.text!
            }
        }
    }
 

}
