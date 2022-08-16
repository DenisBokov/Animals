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
    @IBOutlet var activityIndView: UIActivityIndicatorView!
    
    func configure(with animal: Animal) {
        nameAnimalLebal.text = animal.name
        
        activityIndView.startAnimating()
        activityIndView.hidesWhenStopped = true
        
//        NetworkManager.shared.fetchAnimalImage(from: animal.imageLink) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.imageAnimalView.image = UIImage(data: imageData)
//                self?.activityIndView.stopAnimating()
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        NetworkManagerWithAlamofire.shared.fetchData(from: animal.imageLink) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageAnimalView.image = UIImage(data: imageData)
                self?.activityIndView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
