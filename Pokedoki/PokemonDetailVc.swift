//
//  PokemonDetailVc.swift
//  Pokedoki
//
//  Created by hassen klai on 7/13/16.
//  Copyright © 2016 hassen klai. All rights reserved.
//

import UIKit

class PokemonDetailVc: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var pokemon : Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
        
    }
    
    @IBAction func backButtonPressed(sender :AnyObject!){
        
    }
    
}
