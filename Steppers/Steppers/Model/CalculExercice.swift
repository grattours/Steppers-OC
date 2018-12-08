//
//  CalculExercice.swift
//  Steppers
//
//  Created by Luc Derosne on 06/12/2018.
//  Copyright © 2018 Luc Derosne. All rights reserved.
//

import UIKit

class CalculExercice {
    
    var consigne : String!
    var titre : String!
    var reponse : Int!
    
    
    init(difficulte : Int) {
        switch difficulte {
        case 3:
            consigne = "Pi x racine de 2"
            titre = "Niveau difficile"
            reponse = 0
            break
        case 2:
            consigne = "8 x 7"
            titre = "Niveau moyen"
            reponse = 56
            break
        case 1:
            consigne = "4 + 4"
            titre = "Niveau facile"
            reponse = 8
            break
        default:
            consigne = "default"
            titre = "default"
            reponse = 0
        }
    }
}

