//
//  ViewController.swift
//  Steppers
//
//  Created by Luc Derosne on 04/12/2018.
//  Copyright © 2018 Luc Derosne. All rights reserved.
//

import UIKit

class Exercice: UIViewController, UITextFieldDelegate {
    
    var modeAuto = false // cache ou pas le bouton de validation
    var coordonneeARetenir : CGPoint! // avant le déplacement
    var xDebutDeplacement : CGFloat!  // pour évaluer la droite et la gauche avec X
    @IBOutlet var lTitle : UILabel!
    @IBOutlet var lConsigne : UILabel!
    
    var niveau : Int!
    
    @IBOutlet weak var tfNombreEntre: UITextField!
    @IBOutlet weak var bFin: UIButton!
    @IBOutlet weak var slValue: UISlider!
    @IBOutlet weak var stepperValue: UIStepper!
    
    var calcul : CalculExercice!
 
    override func viewDidLoad() {
        let img = UIImage(named: "help")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(clicHelp))
        
        super.viewDidLoad()
        tfNombreEntre.delegate = self
        print("niveau : \(String(describing: niveau))")
        // version courte
        //slValue.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longClicSurSlider)))
        // version longue, c'est plus clair en effet
        let selLongPress = #selector(longClicSurSlider)
        let gestLongPress = UILongPressGestureRecognizer(target: self, action: selLongPress)
        gestLongPress.allowableMovement = 200
        slValue.addGestureRecognizer(gestLongPress)
        
        stepperValue.addGestureRecognizer(UIPanGestureRecognizer(target:self, action:#selector(glisserDeposerStepper)))
        //On peut donc changer le texte des labels dynamiquement
        lTitle.text = calcul.titre
        //On doit ajouter = ? à la fin de la consigne
        lConsigne.text = "\(String(describing: calcul.consigne!)) = ?"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem?.title = "home"
    }
    
    @objc func clicHelp(sender : UIBarButtonItem) {
        
    }
    
    @IBAction func clicSurFin(_ sender: UIButton) { //On vérifie que le texte entré par l'utilisateur n'est pas nil
        if let resultat = tfNombreEntre.text, resultat != "" {
            // on à remplacer le dur par du mou
            if Int(resultat) == calcul.reponse {
                alert("Bravo", message: "\(String(calcul.consigne)) = \(String(calcul.reponse))\nC'est une bonne réponse")
            } else {
                alert("Faux", message: "Ce n'est pas la bonne réponse, réessayez !")
            }
        } else {
            alert("Champ vide", message: "Veuillez entrer une valeur")
        }
    }
    
    
    @IBAction func autoOnOff(_ sender: UISwitch) {
        modeAuto = sender.isOn
        bFin.isHidden = modeAuto
    }
    
    @IBAction func texteModifie(_ sender: UITextField) {
        if modeAuto {
            // On vérifie que l'utilisateur n'est pas nil
            if let resultat = sender.text, resultat != "" {
                if Int(resultat)==8{
                    alert("Bravo", message:"C'est une  bonne réponse")
                }
            }
        }
     }
    
    @IBAction func sliderMove(_ sender: UISlider) {
        let entier = Int(sender.value)
        tfNombreEntre.text = "\(entier)"
        stepperValue.value = Double(entier)
    }
    
    @IBAction func stepperTouched(_ sender: UIStepper) {
        let entier = Int(sender.value)
        tfNombreEntre.text = "\(entier)"
        slValue.value = Float(entier)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if modeAuto {
            // On vérifie que l'utilisateur n'est pas nil
            if let resultat = textField.text, resultat != "" {
                if Int(resultat)==8{
                    alert("Bravo", message:"C'est une  bonne réponse")
                }else{
                    alert("Faux", message: "C'est une mauvaise réponse")
                }
            }
        }
        return true
        
    }
            
            
    func alert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        self.view.endEditing(true)
    }
    
    @objc func longClicSurSlider(sender : UILongPressGestureRecognizer) {
        alert("Clic long repéré", message: "Faire un long press sur un slider ne sert à rien.")
    }
    
    @objc func glisserDeposerStepper(sender: UIPanGestureRecognizer){
        let step = sender.view!
        switch sender.state {
            case .began:
                // on retient les coordonnées et le X de départ
               coordonneeARetenir = stepperValue.center
               xDebutDeplacement = stepperValue.center.x
            case .changed:
                // on déplace le stepper et on incrémente ou décrémente la valeur dans les 3 cas
                let coordonneeesToucher = sender.location(in: self.view)
                step.center = coordonneeesToucher
                if stepperValue.center.x > xDebutDeplacement {
                    print("plus")
                    stepperValue.value = stepperValue.value + 1
                    tfNombreEntre.text = "\(stepperValue.value)"
                    slValue.value = Float(stepperValue.value)
                } else {
                    print("moins")
                    stepperValue.value = stepperValue.value - 1
                    tfNombreEntre.text = "\(stepperValue.value)"
                    slValue.value = Float(stepperValue.value)
            }
            case .ended:
                // on anime le stepper et on le raméne au départ
                step.center = coordonneeARetenir
                UIView.animate(withDuration: 2,
                               delay: 3.0,
                               options: [.curveEaseInOut, .autoreverse],
                               animations: {
                                self.stepperValue.transform = CGAffineTransform(rotationAngle: .pi)
                                })
            default:
                break
        }
    }
    func changeValeurDe(_ laValeur: Int) -> Int {
        
        return(laValeur)
    }
}
