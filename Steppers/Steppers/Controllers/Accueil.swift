//
//  Accueil.swift
//  Steppers
//
//  Created by Luc Derosne on 06/12/2018.
//  Copyright © 2018 Luc Derosne. All rights reserved.
//

import UIKit
import MessageUI

class Accueil : UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var leadingcontraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var fermerMenuButton: UIButton!
    
    var menuIsHidden = true
    var modeAuto = false // cache ou pas le bouton de validation
    private var dismissViewTap: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingcontraint.constant = -190
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
        fermerMenuButton.isHidden = true
        // print(menuIsHidden)
        dismissViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        if let tap = dismissViewTap {
            view.addGestureRecognizer(tap)
        } // if let
    }
    
    @objc private func dismissView() {
        guard menuView.isHidden == false else {
            return
        }
        menuView.isHidden = true
        fermerMenuButton.isHidden = false
    }
    
    @IBAction func fermerMenu(_ sender: UIButton) {
        menuView.isHidden = true
        fermerMenuButton.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    // navigationController?.navigationBar.titleTextAttributes = []
        navigationController?.navigationBar.barTintColor = UIColor.blue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showExerciceEasy"{
//            let exo = segue.destination as! Exercice
//            exo.niveau = 1
//        }
//        if segue.identifier == "showExerciceMedium"{
//            let exo = segue.destination as! Exercice
//            exo.niveau = 2
//        }
    }  // fin override
    
    
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        menuView.isHidden = false
        if menuIsHidden {
            leadingcontraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            fermerMenuButton.isHidden = false
        } else {
            leadingcontraint.constant = -190
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            fermerMenuButton.isHidden = true
        }
        menuIsHidden = !menuIsHidden
        // fermerMenuButton.isHidden = !fermerMenuButton.isHidden
        //menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func bTestClic(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let exo = storyboard.instantiateViewController(withIdentifier: "Exercice") as! Exercice
        exo.calcul = CalculExercice(difficulte: sender.tag)
        self.navigationController?.show(exo, sender: self)
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error:Error?) {
        
        switch result {
        case .cancelled:
            print("Mail cancelled")
            break
        case .saved:
            print("Mail saved")
            break
        case .sent:
            print("Mail sent")
            break
        case .failed:
            break       
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
//    @IBAction func bExoClic(sender : UIButton) {
//        // Main.storyboard récup
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        // instance Exercice from storyboard
//        let exo = storyboard.instantiateViewController(withIdentifier: "Exercice") as! Exercice
//        
//        // calcul en fonction du tag du button
//        exo.calcul = CalculExercice(difficulte: sender.tag)
//        
//        //show du nouveau controller
//        self.navigationController?.show(exo, sender: self)
//    }
} // fin class
