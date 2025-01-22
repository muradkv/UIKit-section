//
//  UIStackViewViewController.swift
//  UIKit section
//
//  Created by murad on 20.01.2025.
//

import UIKit

struct DefaultModel {
    let nameLabelText = "Aboba aboba"
    let bioText = "В UIStackView в iOS есть два важных свойства, которые управляют расположением и распределением элементов внутри стека: Alignment (выравнивание) и Distribution (распределение). Давайте разберём, что они означают и как их использовать."
    let image: UIImage = .image3
}

final class TaskUIStackViewViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
    private let containerStackView = UIStackView()
    private let profileImageView = CircularImageView()
    private let nameLabel = UILabel()
    private let bioTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    
    private let profileService: ProfileServiceProtocol
    private let defaultModel = DefaultModel()
    
    //MARK: - Life cycle
    
    // Внедрение зависимости через инициализатор
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupAppearance()
        setupLayout()
        setupGestures()
        loadSavedData()
    }
    
    //MARK: - Embed views
    
    private func embedViews() {
        [containerStackView].forEach {
            view.addSubview($0)
        }
        
        [profileImageView, nameLabel, bioTextView, saveButton].forEach {
            containerStackView.addArrangedSubview($0)
        }
    }
    
    //MARK: - Setup appearance
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 20
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.isUserInteractionEnabled = true
        
        nameLabel.font = .systemFont(ofSize: 44, weight: .bold)
        nameLabel.numberOfLines = 0
        nameLabel.isUserInteractionEnabled = true
        nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        bioTextView.font = .systemFont(ofSize: 20, weight: .medium)
        bioTextView.isScrollEnabled = false
        bioTextView.textAlignment = .center
        bioTextView.isEditable = true
        bioTextView.isUserInteractionEnabled = true
        bioTextView.returnKeyType = .done
        bioTextView.delegate = self
        bioTextView.isSelectable = true
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = .blue
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        
        containerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
        }
        
        bioTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(88)
        }
    }
    
    //MARK: - Methods
    
    private func setupGestures() {
        profileImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        )
        
        nameLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false // Разрешаем другим элементам обрабатывать касания
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true) // Скрывает клавиатуру
    }
    
    @objc private func profileImageViewTapped() {
        view.endEditing(true)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // Источник данных (фотоальбом)
        imagePicker.allowsEditing = false // Отключаем редактирование
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func nameLabelTapped() {
        view.endEditing(true)
        
        let alert = UIAlertController(title: "Change", message: "New name", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                  let name = textField.text,
                  !name.isEmpty
            else {
                return
            }
            
            self.nameLabel.text = name
        }
        
        alert.addAction(confirmAction)
        alert.addTextField()
        
        present(alert, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        saveData()
    }
    
    //MARK: - Persistance methods
    
    // Метод для загрузки данных
    private func loadSavedData() {
        let profile = profileService.loadProfile()
        profileImageView.image = profile.image ?? defaultModel.image
        nameLabel.text = profile.name ?? defaultModel.nameLabelText
        bioTextView.text = profile.bio ?? defaultModel.bioText
    }
    
    // Общий метод сохранения
    private func saveData() {
        profileService.saveProfile(
            image: profileImageView.image,
            name: nameLabel.text,
            bio: bioTextView.text
        )
    }
}

extension TaskUIStackViewViewController: UITextViewDelegate {
    // Автоматически скрываем клавиатуру при нажатии Return
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate

extension TaskUIStackViewViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// layoutSubviews сработает гарантированно, в отличии от viewDidLayoutSubviews, который может сработать до расчета в динамическом StackView
class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
}
