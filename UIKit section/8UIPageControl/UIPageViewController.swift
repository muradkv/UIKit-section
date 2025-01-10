//
//  UIPageViewController.swift
//  UIKit section
//
//  Created by murad on 10.01.2025.
//

import UIKit

struct Onboarding {
    let image: String
    let title: String
    let subtitle: String
    let description: String
}

class UIPageViewController: UIViewController {
    
    //MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let pageControl = UIPageControl()
    
    private let onboardingData = [
        Onboarding(
            image: "image1",
            title: "Welcome",
            subtitle: "Start your journey",
            description: "Learn how to use our app"),
        Onboarding(
            image: "image2",
            title: "Convenience",
            subtitle: "Everything at your hand ",
            description: "Access your data and application functions at any time ")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        setupStackView()
        setupPageControl()
        setupContent()
    }
    
    private func setupScrollView() {
        // Позволяет ScrollView автоматически перелистывать страницы при прокрутке
        scrollView.isPagingEnabled = true
        
        //Скрываем индикатор
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
                
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.width.equalTo(view.snp.width).multipliedBy(CGFloat(onboardingData.count))
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = onboardingData.count
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        pageControl.backgroundStyle = .prominent
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupContent() {
        for i in 0..<onboardingData.count {
            let pageView = createOnboardingPage(index: i)
            stackView.addArrangedSubview(pageView)
        }
    }
    
    private func createOnboardingPage(index: Int) -> UIView {
        let data = onboardingData[index]
        let pageView = UIView()
        
        // Настраиваем UIImageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: data.image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(imageView)
        
        // Настраиваем заголовок
        let titleLabel = UILabel()
        titleLabel.text = data.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(titleLabel)
        
        // Настраиваем подзаголовок
        let subtitleLabel = UILabel()
        subtitleLabel.text = data.subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .darkGray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(subtitleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = data.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(descriptionLabel)

        // Настройка констрейнтов для UIImageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 60),
            imageView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: pageView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: pageView.heightAnchor, multiplier: 0.4)
        ])

        // Настройка констрейнтов для titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: pageView.trailingAnchor, constant: -20)
        ])
        
        // Настройка констрейнтов для subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 19),
            subtitleLabel.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: pageView.trailingAnchor, constant: -20)
        ])

        // Настройка констрейнтов для descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: pageView.trailingAnchor, constant: -30)
        ])
        
        // Добавляем кнопку "Начать" на последнюю страницу
        if index == onboardingData.count - 1 {
            let startButton = UIButton(type: .system)
            startButton.setTitle("Начать", for: .normal)
            startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            startButton.backgroundColor = .systemBlue
            startButton.setTitleColor(.white, for: .normal)
            startButton.layer.cornerRadius = 10
            startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

            startButton.translatesAutoresizingMaskIntoConstraints = false
            pageView.addSubview(startButton)

            NSLayoutConstraint.activate([
                startButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                startButton.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                startButton.widthAnchor.constraint(equalToConstant: 150),
                startButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        return pageView
    }
    
    @objc private func startButtonTapped() {
        print("Переход на след экран")
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let xOffset = CGFloat(sender.currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}

extension UIPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        
        pageControl.currentPage = currentPage
    }
}
