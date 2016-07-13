//
//  ViewController.swift
//  Pokedoki
//
//  Created by hassen klai on 7/13/16.
//  Copyright © 2016 hassen klai. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionsView : UICollectionView!
    var pokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsView.delegate = self
        collectionsView.dataSource = self
        parsePokemonCSV()
        
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let name = String(row["identifier"]!)
                let poke = Pokemon(name: name, pokeDexId: pokeId!)
                pokemon.append(poke)
            }
        }
        catch let err as NSError
        {
            print(err.description)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokeCell", forIndexPath: indexPath) as? pokeCell{
            
            let pokem = pokemon[indexPath.row]
            cell.configureCell(pokem)
    
            return cell
        }
            
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}