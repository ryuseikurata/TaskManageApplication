
//  File.swift
//  TaskManage
//
//  Created by 倉田　隆成 on 2018/06/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit
import Foundation

protocol CreateTaskViewDelegate: class {
    func createView(taskEditting view: CreateTaskView, text: String)
    func createView(deadlineEditting view: CreateTaskView, deadline: Date)
    func createView(saveButtonDidTap view: CreateTaskView)
}

class CreateTaskView: UIView {
    
    private var taskTextField: UITextField! //タスク内容を入力する
    private var datePicker: UIDatePicker!
    private var deadlineTextField: UITextField!
    private var saveButton: UIButton
    
    weak var delegate: CreateTaskViewDelegate? //デリゲート
    
    required override init(frame: CGRect){
        super.init(frame: frame)
        
        taskTextField = UITextField()
        taskTextField.delegate = self
        taskTextField.tag = 0
        taskTextField.placeholder = "予定を入れてください"
        addSubview(taskTextField)
        
        deadlineTextField = UITextField()
        deadlineTextField.tag = 1
        deadlineTextField.placeholder = "期限を入れてください"
        addSubview(deadlineTextField)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self,
                             action: #selector(datePickerValueChanged(_:)),
                             for: .valueChanged)
        
        deadlineTextField.inputView = datePicker
        
        saveButton = UIButton()
        saveButton.setTitle("保存する", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 4.0
        saveButton.addTarget(self,
                             action: #selector(saveButtonTapped(_:)),
                             for: .touchUpInside)
        addSubview(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        /*saveボタンが押された時に呼ばれるメソッド。
         押したという情報をCreateTaskVieControllerに伝達している*/
        delegate?.createView(saveButtonDidTap: self)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        /* UIDatePickeの値がが変わった時に呼ばれるメソッド.
         sender.dateがユーザー選択した締切日時で、DateFormatterを用いてStringに変換し,
         deadlineTextField.textに代入している。また、日時の情報をCreateTaskviewcontrollreに伝達している*/
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        deadlineTextField.text = deadlineText
        delegate?.createView(deadlineEditting: self, deadline: sender.date)
    }
}

override func layoutSubViews() {
    super.layoutSubviews()
    
    taskTextField.frame = CGRect(x: bounds.origin.x + 30,
                                 y: bounds.origin.y + 30,
                                 width: bounds.size.width - 60,
                                 height: 50)
    
    deadlineTextField.frame = CGRect(x: taskTextField.frame.origin.x,
                                     y: taskTextField.frame.maxY + 30,
                                     width: taskTextField.frame.size.width,
                                     height: taskTextField.frame.size.height)
    
    let saveButtonSize = CGSize(width: 100, height: 50)
    
    saveButton.frame = CGRect(x: (bounds.size.width - saveButtonSize.width) / 2,
                              y: deadlineTextField.frame.maxY + 20,
                              width: saveButtonSize.width,
                              height: saveButtonSize.height)
    
    
}

extension CreateTaskView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            /*
             textField.tagで識別している。もしtagが0の時、textfield.textすなわち
             ユーザーが入力したタスクもCreateTaskViewControllreに伝達している*/
            delegate?.createView(taskEdittin: self, text: textField.text ?? "")
        }
        return true
    }
}

