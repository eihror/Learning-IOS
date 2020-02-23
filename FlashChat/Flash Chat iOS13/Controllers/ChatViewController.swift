//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data:
                [K.FStore.senderField: messageSender,
                 K.FStore.bodyField: messageBody,
                 K.FStore.dateField: Date().timeIntervalSince1970]
            ) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore \(e)")
                }else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signin out: %@", signOutError)
        }
    }
    
    private func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("Something goes wrong: \(e)")
            }else{
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let message = document.data()
                        if let sender = message[K.FStore.senderField] as? String, let body = message[K.FStore.bodyField] as? String {
                            
                            self.messages.append(Message(sender: sender, body: body))
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        let isValidUser = message.sender == Auth.auth().currentUser?.email
        
        cell.leftImageView.isHidden = isValidUser ? true : false
        cell.rightImageView.isHidden = isValidUser ? false : true
        cell.messageBubble.backgroundColor = isValidUser ? UIColor.init(named: K.BrandColors.lightPurple) : UIColor.init(named: K.BrandColors.purple)
        cell.label.textColor = isValidUser ? UIColor.init(named: K.BrandColors.purple) : UIColor.init(named: K.BrandColors.lightPurple)
        
        return cell
    }
    
    
}
