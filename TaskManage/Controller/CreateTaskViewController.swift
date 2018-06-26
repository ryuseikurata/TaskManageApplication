//
//  File.swift
//  TaskManage
//
//  Created by 倉田　隆成 on 2018/06/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    
    fileprivate var dataSource: TaskDataSource!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //*createTaskを生成し、デリゲートにselfをセットしている
        
        createTaskView  = CreateTaskView(frame: <#CGRect#>)
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        
        //TaskdataSourceを生成。
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        //CreateTaskview
        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)
    }
    
    //保存が終了した時のアラート
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    //タスクが保存した時のアラート
    fileprivate func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください",
                                              message: nil,
                                              preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    /*締切日が未入力の時のアラート
    締切日が未入力の時に保存して欲しくない*/
    
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}


//createTaskViewDelegateメソッド
extension CreateTaskViewController: CreateTaskViewDelegate {
    func createView(taskEditting view: CreateTaskView, text: String) {
        //タスク入力している時に呼ばれるデータメソッド
        taskText = text
    }
    
    func createView(deadlineEditting view: CreateTaskView, deadline: Date) {
        //締切日を入力している時に呼ばれるメソッド
        taskDeadline = deadline
    }
    
    func createView(saveButtonDidTap view: CreateTaskView) {
        /*保存ボタンがタップされた時に呼ばれるメソッド
    createTaskViewからタスク内容を受け取り、textTaskに代入している*/
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
    
    
    
    
    
    
    
    
    
}
