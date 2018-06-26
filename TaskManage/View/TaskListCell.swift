//
//  TaskListCell.swift
//  TaskManage
//
//  Created by 倉田　隆成 on 2018/06/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit
import Foundation

class TaskListCell: UITableViewCell {
    private var taskLabel: UILabel!
    private var deadlineLavel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        taskLabel = UILabel()
        taskLabel.textColor = UIColor.black
        taskLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(taskLabel)
        
        deadlineLavel = UILabel()
        deadlineLavel.textColor = UIColor.black
        deadlineLavel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(deadlineLavel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        taskLabel.frame = CGRect(x: 15.0,
                                 y: 15.0,
                                 width: contentView.frame.width - (15.0 * 2),
                                 height: 15)
        deadlineLavel.frame = CGRect(x: taskLabel.frame.origin.x,
                                     y: taskLabel.frame.origin.y,
                                     width: taskLabel.frame.width,
                                     height: 15.0)
    }
    
    var task: Task? {
        didSet {
            guard let t = task else { return }
            taskLabel.text = t.text
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            deadlineLavel.text = formatter.string(from: t.deadline)
        }
    }
}
