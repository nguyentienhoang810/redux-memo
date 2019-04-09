//
//  ViewController.swift
//  memo-redux
//
//  Created by nguyentienhoang on 2019/02/16.
//  Copyright © 2019 nguyentienhoang. All rights reserved.
//

import UIKit
import ReSwift

struct Task {
    var name: String?
}

struct AppState: StateType {
    var tasks = [Task]()
}

struct AddTask: Action {
    var name: String?
}

struct DeleteTask: Action {
    var index: Int?
}


//Reducer sẽ dựa vào Action để trả về một State mới từ State hiện tại.
//Như đoạn code trên nếu là action AddTask thì sẽ insert một task mới với mô tả name được truyền vào,
//còn nếu là action DeleteTask thì sẽ delete đi task với index được mô tả trong action.
func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case let addTask as AddTask:
        let task = Task(name: addTask.name ?? "undefined name")
        state.tasks.insert(task, at: 0)
    case let deleteTask as DeleteTask:
        state.tasks.remove(at: deleteTask.index ?? 0)
    default:
        return state
    }

    return state
}

//Nhiệm vụ của store là lưu trữ state của ứng dụng
//và phản hồi state mới tới các View subscribe đến nó.
//Một ứng dụng chỉ có duy nhất một Store (nguyên lý 1 single source of truth)
//chứa tất các state cần thiết cho ứng dụng.
let store = Store<AppState>(reducer: appReducer, state: AppState())



class ViewController: UIViewController, StoreSubscriber {
    func newState(state: AppState) {
        self.tasks = state.tasks
    }

    typealias StoreSubscriberStateType = AppState
    var tasks = [Task]() {
        didSet {
            tableView.reloadData()
        }
    }

    var taskNumber = 0

    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.estimatedRowHeight = 200
        return tb
    }()

    private lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Add task", for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.unsubscribe(self)
    }

    @objc func addTask() {
        taskNumber += 1
        let addTaskAction = AddTask(name: "new Task \(taskNumber)")
        store.dispatch(addTaskAction)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deleteAction = DeleteTask(index: indexPath.row)
        store.dispatch(deleteAction)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = tasks[indexPath.row].name ?? "no name"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension ViewController {
    private func addSubview() {
        view.addSubview(tableView)
        view.addSubview(addBtn)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false

        tableView.layer.borderColor = UIColor.orange.cgColor
        tableView.layer.borderWidth = 1

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addBtn.addTarget(self, action: #selector(addTask), for: .touchUpInside)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),

            addBtn.heightAnchor.constraint(equalToConstant: 30),
            addBtn.widthAnchor.constraint(equalToConstant: 200),
            addBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}
