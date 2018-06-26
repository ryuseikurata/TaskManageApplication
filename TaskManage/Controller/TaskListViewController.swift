//
//  TaskListViewController.swift
//  TaskManage
//
//  Created by 倉田　隆成 on 2018/06/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
    
    var dataSource: TaskDataSource!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = TaskDataSource()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(barButtonTapped(_ :)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.loadData()
        tableView.reloadData()
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
        //タスク作成画面へ画面作成
        let controller = CreateTaskViewController()
        present(controller, animated: true, completion: nil)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        as! TaskListCell
        
        //indexPathに応じたTaskを取り出す
        let task = dataSource.data(at: indexPath.row)
        
        //taskをcellに渡している
        cell.task = task
        return cell
    }
    
    
    
}
