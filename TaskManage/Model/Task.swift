//
//  Task.swift
//  TaskManage
//
//  Created by 倉田　隆成 on 2018/06/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import Foundation

class Task {
    let text: String
    let deadline: Date
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(deadline, forKey: "deadline")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "text") as! String
        deadline = aDecoder.decodeObject(forKey: "deadline") as! Date
    }
    /*
 引数からtextとdeadlineを受け取り、Taskを生成するinitializeメソッド
 */
    init(text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    /*
     引数のdictionaryからtaskを生成するイニシャライザ。
     UserDefaultで保存したdictonaryから生成することを目的としている。
     */
    init(from dictionary: [String: Any]) {
        self.text = dictionary["text"] as! String
        self.deadline = dictionary["deadline"] as! Date
    }
}




