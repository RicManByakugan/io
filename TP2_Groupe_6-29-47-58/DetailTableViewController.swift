//
//  DetailTableViewController.swift
//  TP2_Groupe_6-29-47-58
//
//  Created by Fancisco Noam on 28/05/2024.
//

import UIKit

class DetailTableViewController: UIViewController {

   
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var titre_view: UILabel!
    @IBOutlet weak var continent_view: UILabel!
    
    var selectedImage: UIImage?
    var titre: String?
    var continent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = selectedImage {
            self.image_view.image = image
        }
        self.titre_view.text = titre
        self.continent_view.text = continent
    }

    

    
}
