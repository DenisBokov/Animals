//
//  ViewController.swift
//  Animals
//
//  Created by Denis Bokov on 12.08.2022.
//

import UIKit


 
class MainViewController: UICollectionViewController {
    
    private let url = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
    private var animals: [Animal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getAnimal()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalButtonCell", for: indexPath) as? AnimalActionCell else { return UICollectionViewCell() }
        
        let animal = animals[indexPath.item]
        cell.configure(with: animal)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let animal = animals[indexPath.row]
        guard let infoAnimalVC = segue.destination as? InfoAnimalViewController else { return }
        infoAnimalVC.animal = animal
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 250)
    }
}

extension MainViewController {
    private func getAnimal() {
        NetworkManager.shared.fetch([Animal].self, from: url) { [weak self] result in
            switch result {
            case .success(let animals):
                self?.animals = animals
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
