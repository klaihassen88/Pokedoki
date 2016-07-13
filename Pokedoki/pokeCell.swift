//
//  pokeCell.swift
//  Pokedoki
//
//  Created by hassen klai on 7/13/16.
//  Copyright © 2016 hassen klai. All rights reserved.
//

import UIKit

class pokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon :Pokemon){
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemon.pokeDexId)")
        
        
    }

}
