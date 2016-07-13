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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsView.delegate = self
        collectionsView.dataSource = self
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokeCell", forIndexPath: indexPath) as? pokeCell{
            
            let pokemon = Pokemon(name: "test", pokeDexId: indexPath.row)
            cell.configureCell(pokemon)
            
            
            
            
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
        return 718
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}

