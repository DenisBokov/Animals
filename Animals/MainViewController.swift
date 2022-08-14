//
//  ViewController.swift
//  Animals
//
//  Created by Denis Bokov on 12.08.2022.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    let url = "https://zoo-animal-api.herokuapp.com/animals/rand/3"

    override func viewDidLoad() {
        super.viewDidLoad()
        getAnimal()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalButtonCell", for: indexPath) as? AnimalActionCell else { return UICollectionViewCell() }
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
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error Description")
                return
            }
            
            do {
                let animals = try JSONDecoder().decode([Animal].self, from: data)
                
                animals.forEach { animal in
                    print(animal.name)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
