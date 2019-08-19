//
//  ViewController.swift
//  SwiftPost
//
//  Created by David Rossouw on 2019-08-17.
//  Copyright © 2019 David Rossouw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendMessage(_ sender: UIButton) {
        let alertController = UIAlertController(title: "New Message", message: "Enter new message", preferredStyle: .alert)
        alertController.addTextField {textfield in textfield.placeholder = "Your message ..."}
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Send", style: .default, handler: {action in
            guard let text = alertController.textFields?.first?.text else {print("No text available"); return}
            
            let message = Message(message: text)
            let postRequest = APIRequest(endpoint: "api/messages")
            
            postRequest.send(message, completion: {result in
                switch result {
                case .success(let message):
                    print("The following message has been sent: \(message.message)")
                case .failure(let error):
                    print("An error has occurred: \(error))")
                }
            })
        }))
        
    self.present(alertController, animated: true)
    }
    
}

