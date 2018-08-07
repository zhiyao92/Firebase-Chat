//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Kelvin Tan on 8/3/18.
//  Copyright © 2018 Kelvin Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref = DatabaseReference.init()
    var name: String = ""
    var listChat = [Chat]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAnonymous()
        
        self.ref = Database.database().reference()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    func loginAnonymous(){
        Auth.auth().signInAnonymously(){
            (authRequest, error) in
            if let error = error {
                print("Error \(error)")
            } else {
                print("User: \(authRequest?.user.uid)")
                self.loadChat()
            }
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let dictionary = [ "name" : name, "message" : messageTextField.text!, "postDate" : ServerValue.timestamp()] as [String:Any]
        self.ref.child("chat").childByAutoId().setValue(dictionary)
        messageTextField.text = ""
    }
    
    func loadChat(){
        self.ref.child("chat").queryOrdered(byChild: "datePost").observe(.value, with: { (snapshot) in
                self.listChat.removeAll()
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if let data = snap.value as? [String: AnyObject] {
                            let text = data["message"] as? String
                            let name = data["name"] as? String

                            let date =  data["postDate"]
                            let dateValue = Date(timeIntervalSince1970: date as! TimeInterval)

                            self.listChat.append(Chat(name: name!, message: text!, datePost: "\(dateValue)"))
                        }
                    }
                    self.tableView.reloadData()
                    let indexPath = IndexPath(row: self.listChat.count-1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageTableViewCell
        cell?.setChat(chat: listChat[indexPath.row])
        return cell!
    }


}

