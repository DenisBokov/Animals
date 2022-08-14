//
//  AnimalActionCellCollectionViewCell.swift
//  Animals
//
//  Created by Denis Bokov on 13.08.2022.
//

import UIKit

class AnimalActionCell: UICollectionViewCell {
    @IBOutlet var nameAnimalLebal: UILabel!
    @IBOutlet var imageAnimalView: UIImageView!
    
    func configure(with animal: Animal) {
        nameAnimalLebal.text = animal.name
        
        guard let url = URL(string: animal.image_link) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self?.imageAnimalView.image = UIImage(data: imageData)
            }
        }
    }
}
