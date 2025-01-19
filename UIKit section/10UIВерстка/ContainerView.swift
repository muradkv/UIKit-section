//
//  ContainerView.swift
//  UIKit section
//
//  Created by murad on 19.01.2025.
//

import UIKit

class ContainerView: UIView {
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupLayout()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupL layout

private extension ContainerView {
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-16)
            make.height.equalTo(18)
            make.width.equalTo(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

//MARK: - Embed views

private extension ContainerView {
    func embedViews() {
        addSubview(titleLabel)
        addSubview(imageView)
    }
}

//MARK: - Setup appearance

private extension ContainerView {
    func setupAppearance() {
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        
        backgroundColor = .orange
        layer.cornerRadius = 20 
    }
}

//MARK: - Set text

extension ContainerView {
    func set(text: String) {
        titleLabel.text = text
    }
}

//MARK: - Set image

extension ContainerView {
    func set(image: UIImage) {
        imageView.image = image
    }
}

//Вариант 1 через forEach

//extension Task3UILayoutViewController {
//    struct ContainerModel {
//        let id: Int
//        let text: String
//        let image: UIImage
//    }
//
//    //let containerPlaceHolder = UIStackView()
//
//    //private let containers = [
//    //    ContainerView(),
//    //    ContainerView(),
//    //    ContainerView()]
//
////    private let containersModels = [
////    ContainerModel(name: "Continue with email", image: .mail),
////    ContainerModel(name: "Continue with mobile", image: .phone),
////    ContainerModel(name: "Continue with secret question", image: .mail)]
//
//    containers.forEach { view in
//        containerPlaceHolder.addArrangedSubview(view)
//    }
//
//    func setupContainersData() {
//        //не совсем оптимально из-за вложенности, можно по другому
//        containers.forEach { view in
//            containersModels.forEach { model in
//                view.set(text: model.name)
//                view.set(image: model.image)
//            }
//        }
//    }
//
//    func setupAppearance() {
//        containerPlaceHolder.axis = .vertical
//        containerPlaceHolder.distribution = .fill
//        containerPlaceHolder.alignment = .fill
//        containerPlaceHolder.spacing = 24
//    }
//
//}


// Вариант 2

/*
let containerStackView = UIStackView()

private let containers = [
    ContainerView() : ContainerModel(id: 1, name: "Continue with email", image: .mail),
    ContainerView() : ContainerModel(id: 2, name: "Continue with mobile", image: .phone),
    ContainerView() : ContainerModel(id: 3, name: "Continue with secret question", image: )
],.sorted { $0.value.id < $1.value.id }

private extension ... {

    func setupContainers() {
        containers.forEach { view, model in
            containerStackView.addArrangedSubview(view)
            view.set(text: model.name)
            view.set(image: model.image)
        }
    }
    
    containerStackView.alignment = .fill
    containerStackView.axis = .vertical
    containerStackView.distribution = .fill
    containerStackView.spacing = 24
    
    containerStackView.snp.makeConstraints { make in
        make.top.equalTo(descriptionLabel.snp.bottom).offset(48)
        make.horizontalEdges.equalToSuperview().inset(24)
        make.bottom.lessThanOrEqualTo(view.snp.bottom).offset(-48)
    }
}
*/
