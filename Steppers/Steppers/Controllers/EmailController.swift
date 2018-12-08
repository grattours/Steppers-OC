//
//  EmailController.swift
//  Steppers
//
//  Created by Luc Derosne on 07/12/2018.
//  Copyright © 2018 Luc Derosne. All rights reserved.
//

import UIKit
import MessageUI

class EmailController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var leTexteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func envoyerEmail(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let message:String  = leTexteView.text
            let composePicker = MFMailComposeViewController()
            composePicker.mailComposeDelegate = self
            composePicker.delegate = self as? UINavigationControllerDelegate
            composePicker.setToRecipients(["toto@gmail.com"])
            composePicker.setSubject("Penser à ...")
            composePicker.setMessageBody(message, isHTML: false)
            self.present(composePicker, animated: true, completion: nil)
        }
        else {
            self .showerrorMessage()
        }
    }
    
    func showerrorMessage() {
        let alertMessage = UIAlertController(title: "l'email ne peut pas être envoyé ", message: " Vérifiez si votre mobil à bien une messagerie ! ", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: nil)
        alertMessage.addAction(action)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        switch result {
        case .cancelled:
            print("Email supprimé")
            break
        case .saved:
            print("Email sauvé")
            break
        case .sent:
            print("Email envoyé")
            break
        case .failed:
            break
        }
        self.dismiss(animated: true, completion: nil)
        
    }
}
