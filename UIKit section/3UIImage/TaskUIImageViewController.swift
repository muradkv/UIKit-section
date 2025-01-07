//
//  UIImageViewController.swift
//  UIKit section
//
//  Created by murad on 07.01.2025.
//

import UIKit

class TaskUIImageViewController: UIViewController {
    private let images = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3")]
    private var currentIndex = 0
    var count = 0
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = images[currentIndex]
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 2
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureSwipe()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(previousButton)
        buttonStackView.addArrangedSubview(nextButton)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(500)
            make.centerY.equalTo(view.snp.centerY).offset(-40)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(imageView.snp.width)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        previousButton.addAction(UIAction(handler: { action in
            self.tapButton(state: .previous)
        }), for: .touchUpInside)
        
        nextButton.addAction(UIAction(handler: { action in
            self.tapButton(state: .next)
        }), for: .touchUpInside)
    }
    
    private func configureSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        imageView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        imageView.addGestureRecognizer(swipeRight)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        switch gesture.state {
        case .began, .changed:
            // Применяем масштаб к изображению
            view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1.0 // Сбрасываем scale до 1.0 для следующего изменения
        case .ended:
            // Дополнительные действия после завершения жеста
            print("Масштабирование завершено")
        default:
            break
        }
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            tapButton(state: .next)
        } else if gesture.direction == .right {
            tapButton(state: .previous)
        }
    }
    
    private func tapButton(state: TapState) {
        switch state {
        case .previous:
            if currentIndex == 0 {
                return
            }
            currentIndex -= 1
            animateSwipeImage(state: .previous)
        case .next:
            if currentIndex == images.count - 1 {
                return
            }
            currentIndex += 1
            animateSwipeImage(state: .next)
        }
    }
    
    private func animateSwipeImage(state: TapState) {
        switch state {
        case .previous:
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform(translationX: 50, y: 0)
            }, completion: { _ in
                // Сброс анимации после завершения
                UIView.animate(withDuration: 0.3) {
                    self.imageView.transform = .identity
                    self.imageView.image = self.images[self.currentIndex]
                }
            })
        case .next:
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.transform = CGAffineTransform(translationX: -50, y: 0)
            }, completion: { _ in
                // Сброс анимации после завершения
                UIView.animate(withDuration: 0.3) {
                    self.imageView.transform = .identity
                    self.imageView.image = self.images[self.currentIndex]
                }
            })

        }
    }
    
}

enum TapState {
    case previous
    case next
}

#Preview(traits: .portrait) {
    TaskUIImageViewController()
}
