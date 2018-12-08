//
//  boutonArrondi.swift
//  Steppers
//
//  Created by Luc Derosne on 04/12/2018.
//  Copyright © 2018 Luc Derosne. All rights reserved.
//

import UIKit
class BoutonArrondi : UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        //Initialiseur de la classe parente
        super.init(coder: aDecoder)
        
        //Coins arrondis
        layer.cornerRadius = 5
        
        //Couleur de la bordure
        layer.borderColor = UIColor.red.cgColor
        
        //Couleur de la bordure
        layer.borderColor = UIColor.red.cgColor
        
        //Couleur du texte
        setTitleColor(UIColor.red, for: .normal)
        
        //Epaisseur de la bordure
        layer.borderWidth = 2

        //Padding a gauche et a droite
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
}
