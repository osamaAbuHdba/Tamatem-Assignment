//
//  ViewController.swift
//  Tamatem Assignment
//
//  Created by Osama Abu Hdba on 31/05/2023.
//

import UIKit

class WelcomeViewController: UIViewController {
// MARK: - view Component
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to Tamatem Plus"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ready to join the journey ?"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.loadGif(asset: "fortnite")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()

    lazy var goToWebSiteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle( "Go To Website", for: .normal)
        button.setTitleColor(.buttonTitleColor, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 9
        button.backgroundColor = .buttonBackground
        return button
    }()

// MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setupNavigation()
        setupViews()
        connectActions()
    }

// MARK: - private methods
    private func setupNavigation() {
        self.navigationItem.title = "Tamatem 🍅"
    }

    private func setupViews() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(goToWebSiteButton)

        stackView.setCustomSpacing(50, after: titleLabel)
        stackView.setCustomSpacing(50, after: subTitleLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -25),
            goToWebSiteButton.heightAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func connectActions() {
        goToWebSiteButton.addTarget(self, action: #selector(userTappedOnGoToWebsite), for: .touchUpInside)
    }

// MARK: - Action methods
    @objc func userTappedOnGoToWebsite() {
        guard let url = URL(string: "https://www.tamatemplus.com") else {return}
        let viewController = WebViewController(url: url, title: "Tamatem")
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

