//
//  ViewController.swift
//  Pokedoki
//
//  Created by hassen klai on 7/13/16.
//  Copyright © 2016 hassen klai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicImg :UIButton!
    @IBOutlet weak var collectionsView : UICollectionView!
    var pokemon = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    var filtredPokemon = [Pokemon]()
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionsView.delegate = self
        collectionsView.dataSource = self
        
        parsePokemonCSV()
        
        initAudio()
        musicImg.layer.cornerRadius = musicImg.frame.width/2
        musicImg.clipsToBounds = true
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionsView.reloadData()
            
        }
        else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filtredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collectionsView.reloadData()
        }
        
    }
    
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("PokemonSongFull", ofType: "mp3")
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError {
            print(err.description)
        }
    }
    
    
    @IBAction func musicPressedButton(sender :UIButton!){
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.5
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
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
            let pokem : Pokemon!
            
            if inSearchMode {
                
                pokem = filtredPokemon[indexPath.row]
            }
            else {
                pokem = pokemon[indexPath.row]
            }
            
            cell.configureCell(pokem)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke : Pokemon!
        if inSearchMode {
            poke = filtredPokemon[indexPath.row]
        }
        else {
            poke = pokemon[indexPath.row]
        }
        performSegueWithIdentifier("PokemonDetailsVC", sender: poke)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailsVC" {
            if let detailsVc = segue.destinationViewController as? PokemonDetailVc {
                if let poke = sender as? Pokemon{
                    detailsVc.pokemon = poke
                }
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filtredPokemon.count
        }
        else {
            return pokemon.count
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}