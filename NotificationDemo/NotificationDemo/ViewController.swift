//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Appinventiv on 04/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        tableView.dataSource = self

        tableView.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.shortenView(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.extendView(notification:)),
            name: .UIKeyboardWillHide,
            object: nil)
    
    }
    
    func shortenView(notification : Notification){
        
        guard let user = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return}
        
        let keyboardHeight = user.cgRectValue.height
        
        UIView.animate(withDuration: 0.5, animations: {
        
            self.bottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        
        })
    }

    func extendView(notification : Notification){
        
        self.bottomConstraint.constant = 0
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 20
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCellID", for: indexPath) as! PrototypeCell
        
        return cell
    
    }
}

class PrototypeCell : UITableViewCell {

    @IBOutlet weak var enterInfo: UITextField!

}
