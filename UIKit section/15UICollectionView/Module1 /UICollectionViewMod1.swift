//
//  UICollectionView1.swift
//  UIKit section
//
//  Created by murad on 25.01.2025.
//

import UIKit

final class UICollectionViewMod1: UIViewController {
    
    //MARK: - Properties
    
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private let button = UIButton(type: .system)
    
    // 1 section
//    private let source: [Photo] = Source.randomPhotos(with: 15)
    // 2 sections
    let source: [SectionPhoto] = [
        SectionPhoto(sectionName: "First Section", photos: Source.randomPhotos(with: 7)),
        SectionPhoto(sectionName: "Second Section", photos: Source.randomPhotos(with: 13))
    ]
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupButton()
    }
    
    //MARK: - Setup UI
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "\(PhotoCollectionViewCell.self)")
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderReusableView.self)")
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        //Фикс размер
        //layout.itemSize = CGSize(width: 200, height: 200)
        
        //Использует предполагаемые размеры для начальной настройки, а затем уточняет их на основе реального содержимого
        //Размер под контент, тогда задать размер в ячейках на констрейнтах width/height
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        
        //Не устанавливает предполагаемые размеры, а сразу берет размеры с auto layout
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        layout.headerReferenceSize = .init(width: view.frame.size.width, height: 60)
        
        return layout
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        button.setTitle("Change", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        layout.scrollDirection = layout.scrollDirection == .horizontal ? .vertical : .horizontal
        
        UIView.animate(withDuration: 1) {
            self.collectionView.layoutIfNeeded()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension UICollectionViewMod1: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        source[section].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCollectionViewCell.self)", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.photoImageView.image = UIImage(named: source[indexPath.section].photos[indexPath.row].imageName)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderReusableView.self)", for: indexPath) as? HeaderReusableView else  {
                return UICollectionReusableView()
            }
            view.titleLabel.text = source[indexPath.section].sectionName
            return view
            
        default: return UICollectionReusableView()
        }
    }
}

extension UICollectionViewMod1: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            cell.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            cell.contentView.backgroundColor = .clear // Возвращаем исходный цвет
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Select", message: "Section - \(indexPath.section), Item - \(indexPath.item)", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    //Действие на показ какого-либо элемента из ячеек
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSection = source.count - 1
        let lastItem = source[lastSection].photos.count - 1

        let lastIndexPath = IndexPath(item: lastItem, section: lastSection)

        if indexPath == lastIndexPath {
            print("Your awesome code")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        print("Display header with element kind \(elementKind)")
    }
}
