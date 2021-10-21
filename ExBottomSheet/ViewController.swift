//
//  ViewController.swift
//  ExBottomSheet
//
//  Created by 김종권 on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {

    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc func didTapNextButton() {
        showMyViewController()
    }

    func showMyViewController() {
        let navigationController = UINavigationController(rootViewController: MyViewController())
        present(navigationController, animated: true, completion: nil)
    }
}

extension ViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {

    }
}
