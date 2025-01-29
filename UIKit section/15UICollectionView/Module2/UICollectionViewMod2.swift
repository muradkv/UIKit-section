//
//  UICollectionViewMod1.swift
//  UIKit section
//
//  Created by murad on 28.01.2025.
//

import UIKit

final class UICollectionViewMod2: UIViewController {
    //MARK: - Properties
    
    private var collectionView: UICollectionView!
    private var images: [UIImage?] = []
    private let apiManager = APIManagerMod2()
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        embededViews()
        setupLayout()
        
        loadImage()
    }
    
    //MARK: - Embed views
    
    private func embededViews() {
        view.addSubview(collectionView)
    }
    
    //MARK: - Setup appearance
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.register(ImageCollectionCellMod2.self, forCellWithReuseIdentifier: "\(ImageCollectionCellMod2.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false 
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(200)
        }
    }
    
    //MARK: - Methods
    
    private func loadImage() {
        let imagesId = [1, 33, 3, 44, 101, 6, 7, 11, 22]
        var images = [UIImage?]()
        
        let group = DispatchGroup()
        imagesId.forEach {
            group.enter()
            apiManager.loadImage(id: $0) { image in
                images.append(image)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.images = images
            self.collectionView.reloadData()
        }
    }
    
    private func updateVisibleCells() {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionCellMod2 else { continue }
            if indexPath.item < images.count { // Защита от выхода за пределы массива
                cell.configure(image: images[indexPath.item])
            }
        }
    }
}

//MARK: - CollectionViewDataSource

extension UICollectionViewMod2: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageCollectionCellMod2.self)", for: indexPath) as? ImageCollectionCellMod2 else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: images[indexPath.item])
        
        return cell
    }
}

//MARK: - CollectionViewDelegateFlowLayout

extension UICollectionViewMod2: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)
    }
}
