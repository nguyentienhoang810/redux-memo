//
//  ViewController.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/02/16.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import UIKit
import ReSwift


struct AppState: StateType {
    var counter: Int = 0
}

struct CountActionIncrease: Action {}
struct CountActionDecrease: Action {}


func handleAction(action: Action, state: AppState?) -> AppState {
    //copy current state
    var newState = state ?? AppState()

    switch action {
    case _ as CountActionIncrease:
        let newValue = newState.counter + 1
        newState.counter = newValue

    case _ as CountActionDecrease:
        let newValue = newState.counter - 1
        newState.counter = newValue

    default:
        return newState
    }
    return newState
}


class ViewController: UIViewController {

    private lazy var decreaseBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Decrease", for: .normal)
        return btn
    }()

    private lazy var increaseBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Increase", for: .normal)
        return btn
    }()

    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "00000"
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

}

extension ViewController {
    private func addSubview() {
        view.addSubview(decreaseBtn)
        view.addSubview(increaseBtn)
        view.addSubview(label)

        label.backgroundColor = UIColor.blue.withAlphaComponent(0.2)

        decreaseBtn.translatesAutoresizingMaskIntoConstraints = false
        increaseBtn.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            increaseBtn.heightAnchor.constraint(equalToConstant: 30),
            increaseBtn.widthAnchor.constraint(equalToConstant: 200),
            increaseBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            increaseBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            decreaseBtn.heightAnchor.constraint(equalToConstant: 30),
            decreaseBtn.widthAnchor.constraint(equalToConstant: 200),
            decreaseBtn.bottomAnchor.constraint(equalTo: increaseBtn.topAnchor, constant: -20),
            decreaseBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
