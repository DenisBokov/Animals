//
//  ViewController.swift
//  Animals
//
//  Created by Denis Bokov on 12.08.2022.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    let url = "https://zoo-animal-api.herokuapp.com/animals/rand/3"
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
        
        cell.nameAnimalLebal.text = animals[indexPath.item].name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoAnimalVC = segue.destination as? InfoAboutAnimalViewController else { return }
        infoAnimalVC.fetchAnimal()
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

extension MainViewController {
    private func getAnimal() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error Description")
                return
            }
            
            do {
                self?.animals = try JSONDecoder().decode([Animal].self, from: data)
                print(self?.animals ?? "")
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
