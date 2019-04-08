//
//  ViewController.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/02/16.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import UIKit
import ReSwift

let applicationStore = Store(reducer: AppReducer, state: AppState())

struct AppState: StateType {
    //something like model here
    var text: String?
}

struct InputAction: Action { //state will be changed by action
    var text: String
}


//get new state by action
func AppReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? AppState(text: "") //get current state
    var newState = state //copy current state
    switch action {
    case _ as InputAction:
        newState = AppState(text: (action as! InputAction).text) //process copied state
    default:
        break
    }
    return newState
}

class ViewController: UIViewController, StoreSubscriber {

    func newState(state: AppState) {
        print(state.text ?? "")
    }

    typealias StoreSubscriberStateType = AppState

    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubview()
        button.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
    }

    @objc func tap(_ sender: UIButton) {
        var text = applicationStore.state.text ?? ""
        text = text + "s"
        applicationStore.dispatch(InputAction(text: text))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applicationStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applicationStore.unsubscribe(self)
    }

    private func addSubview() {
        view.addSubview(button)
        button.backgroundColor = .orange
        button.setTitle("Tap Here", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

}

