//
//  TaskDate.swift
//  TaskManage
//
//  Created by 倉田　隆成 on 2018/06/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import Foundation

class TaskDataSource: NSObject {
    //Task一覧を表示するためのArray
    private var tasks = [Task]()
    
    //UserDefaultから保存したデータをTasks一覧を表示
    func loadData() {
        let userDefaults = UserDefaults.standard
        let taskDictionaries = UserDefaults.object(value(forKey: "tasks"))
        as? [[String: Any]]
        guard let t = taskDictionaries else { return }
        
        for dic in t {
            let task = Task(from: dic)
            tasks.append(task)
        }
    }
    
    //TaskをUserDefaultsに保存している
    func save(task: Task) {
        tasks.append(task)
        
        var taskDictionaries = [[String: Any]]()
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries, forKey: "tasks")
        userDefaults.synchronize()
    }
    
    //Taskの総数を返している、UITableViewのcellカウントに使用する
    func count() -> Int {
        return tasks.count
    }
    
    /*指定したindexに対応するTaskを返している。indexには、UITableViewのindexPath.rowがくることを想定する*/
    func data(at index: Int) -> Task? {
        if tasks.count > index {
            return tasks[index]
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
}
