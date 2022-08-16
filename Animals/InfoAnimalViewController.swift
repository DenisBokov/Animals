//
//  InfoAnimalViewController.swift
//  Animals
//
//  Created by Denis Bokov on 16.08.2022.
//

import UIKit

class InfoAnimalViewController: UIViewController {
    
    @IBOutlet var nameAnimalForInfo: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var animal: Animal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameAnimalForInfo.text = animal.name
        descriptionLabel.text = animal.description
    }
}
