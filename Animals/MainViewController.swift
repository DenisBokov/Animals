//
//  ViewController.swift
//  Animals
//
//  Created by Denis Bokov on 12.08.2022.
//

import UIKit



class MainViewController: UICollectionViewController {
    
    let url = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
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
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 500)
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self?.animals = try decoder.decode([Animal].self, from: data)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
