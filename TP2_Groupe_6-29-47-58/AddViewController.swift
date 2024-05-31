//
//  AddViewController.swift
//  TP2_Groupe_6-29-47-58
//
//  Created by Fancisco Noam on 30/05/2024.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var nom_pays: UITextField!
    @IBOutlet weak var iso_pays: UITextField!
    @IBOutlet weak var continent_pays: UITextField!
    
    var countriesTableViewController: CountriesTableViewController? // on appel le controller qui contient la liste des pays
    
    weak var delegate: CountriesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func add_new_pays(_ sender: UIButton) {
        
        guard let nom = nom_pays.text, !nom.isEmpty,
              let iso = iso_pays.text, !iso.isEmpty,
              let continent = continent_pays.text, !continent.isEmpty else {
            
            // On envoie un alert si les conditions ne sont pas respectés
            let alert = UIAlertController(title: "Erreur", message: "Tous les champs doivent être remplis.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let newCountry = Country(isoCode: iso, name: nom, continent: continent)

        // On appel cette action pour validé le nouveau country dans CountriesViewController pour ajouter le nouveau country
        delegate?.addNewCountryInListe(newCountry)
        
        // sert à naviguer en arrière dans la pile de navigation, c'est-à-dire à revenir à l'écran précéden
        self.navigationController?.popViewController(animated: true)
    }
}
