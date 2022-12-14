//
//  ViewController.swift
//  FoodRecipeProject
//
//  Created by MAC on 30.09.2022.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    // MARK: - Property
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifire)
        return collectionView
    }()
    
    var model = [Result]()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchData()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Hierarhy
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: - –°reateLayout
    
    private func createLayout() -> UICollectionViewLayout {
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metric.itemSizeWidth), heightDimension: .fractionalHeight(Metric.itemSizeHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemsSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Metric.groupSizeWidth), heightDimension: .fractionalHeight(Metric.groupSizeHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: Metric.countGroup)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // MARK: - Fetch data from the network
    
    private func fetchData() {
        networkManager.fetchData { [weak self] (recipes) in
            self?.model.append(contentsOf: recipes.results)
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifire, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.recipes = model[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let recipe = model[indexPath.row]
        let vc = DetailRecipeViewController()
        vc.recipe.recipes = recipe
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension CollectionViewController {
    
    enum Metric {
        static let itemSizeWidth: CGFloat = 1.0
        static let itemSizeHeight: CGFloat = 1.0
        static let groupSizeWidth: CGFloat = 0.5
        static let groupSizeHeight: CGFloat = 0.30
        static let countGroup = 2
    }
}
