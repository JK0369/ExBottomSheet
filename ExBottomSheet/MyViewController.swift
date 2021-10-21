//
//  MyViewController.swift
//  ExBottomSheet
//
//  Created by 김종권 on 2021/10/21.
//

import UIKit

class MyViewController: UIViewController {

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self

        return view
    }()

    var dataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "MyViewController"

        for i in 0...100 {
            dataSource.append("\(i)")
        }

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])

        setupSheet()
        addNavigationBarButtonItem()

    }

    private func setupSheet() {
        /// 밑으로 내려도 dismiss되지 않는 옵션 값
        isModalInPresentation = true

        if let sheet = sheetPresentationController {
            /// 드래그를 멈추면 그 위치에 멈추는 지점: default는 large()
            sheet.detents = [.medium(), .large()]
            /// 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            /// sheet아래에 위치하는 ViewController를 흐려지지 않게 하는 경계값 (medium 이상부터 흐려지도록 설정)
            sheet.largestUndimmedDetentIdentifier = .medium
            /// sheet로 present된 viewController내부를 scroll하면 sheet가 움직이지 않고 내부 컨텐츠를 스크롤되도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            /// grabber바 보이도록 설정
            sheet.prefersGrabberVisible = true
            /// corner 값 설정
    //            sheet.preferredCornerRadius = 32.0
        }
    }

    private func addNavigationBarButtonItem() {
        let medium = UIBarButtonItem(title: "medium", primaryAction: .init(handler: { [weak self] _Arg in
            self?.sheetPresentationController?.animateChanges {
                self?.sheetPresentationController?.selectedDetentIdentifier = .medium
            }
        }))
        navigationItem.leftBarButtonItem = medium

        let large = UIBarButtonItem(title: "large", primaryAction: .init(handler: { [weak self] _Arg in
            self?.sheetPresentationController?.animateChanges {
                self?.sheetPresentationController?.selectedDetentIdentifier = .large
            }
        }))
        navigationItem.rightBarButtonItem = large
    }
}

extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}
