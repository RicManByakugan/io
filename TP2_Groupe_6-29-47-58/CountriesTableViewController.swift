//
//  CountriesTableViewController.swift
//  TP2_Groupe_6-29-47-58
//
//  Created by Fancisco Noam on 27/05/2024.
//

import UIKit

class CountriesTableViewController: UITableViewController {

    var countriesByContinent: [String: [Country]] = [:]
        var continents: [String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // utilisation de la fonction group by pour filtrer et trier
            countriesByContinent = Dictionary(grouping: countries, by: { $0.continent })
            continents = countriesByContinent.keys.sorted()
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return continents.count
            // return 1
        }
        
 
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let continent = continents[section]
            return countriesByContinent[continent]?.count ?? 0
            //  return countries.count
        }
        
        // Ajout d'un titre  dans la section qu'on a remplacer par le continent du pays
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return continents[section]
        }
        
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
            
            let continent = continents[indexPath.section]
            if let countriesInSection = countriesByContinent[continent] {
                let country = countriesInSection[indexPath.row]
                cell.textLabel?.text = country.name
                cell.detailTextLabel?.text = country.isoCode
                cell.imageView?.image = UIImage(named: country.isoCode)
            }
            
            return cell
        }
    

    //++++++++++++++++++  Cette fonction permet de prendre le cellule selectionner
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let selectedCountry = countries[indexPath.row]
            
        // Obtenez une référence à votre contrôleur de vue depuis le storyboard
        if let vc = storyboard?.instantiateViewController(identifier: "a") as? DetailTableViewController {
            // Configurez les propriétés du contrôleur de vue avant de le présenter
            vc.titre = selectedCountry.name
            vc.selectedImage = UIImage(named: selectedCountry.isoCode)
            
            // Présentez le contrôleur de vue
            self.navigationController?.pushViewController(vc, animated: true)
        } */
        
        
        let continent = continents[indexPath.section]
        
            if let countriesInSection = countriesByContinent[continent] {
                let selectedCountry = countriesInSection[indexPath.row]
                
                // on recupère le view controller à partir de son storyboard
                if let vc = storyboard?.instantiateViewController(identifier: "DetailTableViewController") as? DetailTableViewController {
                    vc.titre = selectedCountry.name
                    vc.continent = continent
                    vc.selectedImage = UIImage(named: selectedCountry.isoCode)
                    
                    // charge l'interface détail
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
    }
    

    
    //++++++++++++++++++ Ajouter un footer avec un bouton pour ajouter un nouveau pays
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == continents.count - 1 {
            let footerView = UIView()
            footerView.backgroundColor = .clear

            let addButton = UIButton(type: .system)
            addButton.setTitle("Ajouter un nouveau pays", for: .normal)
            addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            addButton.tintColor = .systemBlue
            addButton.addTarget(self, action: #selector(self.getViewAddCountry), for: .touchUpInside)

            addButton.translatesAutoresizingMaskIntoConstraints = false
            footerView.addSubview(addButton)
            
            NSLayoutConstraint.activate([
                addButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                addButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
            ])

            return footerView
        }
        return nil
    }

    
    //++++++++++++++++++ cette fonction permet d'afficher qu'une seule fois le boutton ajout de nouveau pays
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == continents.count - 1 ? 60.0 : 0.0
    }
    
    
    //++++++++++++++++++ Cette fonction permet de charger l'interface AddViewController
    @objc func getViewAddCountry() {
        if let addNewVC = storyboard?.instantiateViewController(identifier: "AddViewController") as? AddViewController {
            addNewVC.delegate = self
            self.navigationController?.pushViewController(addNewVC, animated: true)
        }
    }

    
    //++++++++++++++++++ Cette fonction permet la validation et d'ajout du nouveau pays dans la liste countries
    func addNewCountryInListe(_ country: Country) {
       /* if countries.contains(where: { $0.isoCode.uppercased() == country.isoCode.uppercased() || $0.name.uppercased() == country.name.uppercased() }) {*/
        if countries.contains(where: { $0.name.uppercased() == country.name.uppercased() }) {
            let alert = UIAlertController(title: "Erreur", message: "Le pays existe déjà.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        countries.append(country) // ajouter le nouveau country dans la liste
        
        // Refaire les filtres des affichages
        countriesByContinent = Dictionary(grouping: countries, by: { $0.continent })
        continents = countriesByContinent.keys.sorted()
        
        // On recharge le tablea view pour qu'il met à jour le donner
        tableView.reloadData()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
