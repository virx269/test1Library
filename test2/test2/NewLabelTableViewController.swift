//
//  NewLabelTableViewController.swift
//  test2
//
//  Created by  Виталий on 16.04.2020.
//  Copyright © 2020 Bulavin. All rights reserved.
//

import UIKit

class NewLabelTableViewController: UITableViewController {
    
    var insideEmoji = emoji(emoji: "", name: "", description: "", like: false)
    
    @IBOutlet weak var Label1TextField: UITextField!
    @IBOutlet weak var Label2TextField: UITextField!
     @IBOutlet weak var Label3TextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //метод проверки при загрузки таблицы
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButton()
    }
    
    // функция проверки не пустого текста для кнопки Save, свойство invisible
    private func updateSaveButton() {
        let  Label1Text = Label1TextField.text ?? ""
        let  Label2Text = Label2TextField.text ?? ""
        let  Label3Text = Label3TextField.text ?? ""
        
        saveButton.isEnabled = !Label1Text.isEmpty && !Label2Text.isEmpty && !Label3Text.isEmpty
        
        
    }
    
    //метод проверки функции при изменении текста одном из трех textField'ов
    @IBAction func textChange(_ sender: Any) {
        updateSaveButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let l1 = Label1TextField.text ?? ""
        let l2 = Label2TextField.text ?? ""
        let l3 = Label3TextField.text ?? ""
        self.insideEmoji = emoji(emoji: l1, name: l2, description: l3 , like: self.insideEmoji.like)
    }
}
