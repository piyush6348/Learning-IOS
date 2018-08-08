//
//  ViewController.swift
//  DBMigration
//
//  Created by Piyush Gupta on 08/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        insertIntoDB()
    }

    func insertIntoDB(){
        let classInserted = insertIntoClass()
        let insertedStudent = insertStudent()
        classInserted.addToStudList(insertedStudent)
    }
    func insertIntoClass() -> ClassEntity{
        let classModelObj = ClassEntity(context: context)
        classModelObj.classID = "class01"
        classModelObj.name = "Class 10th"
        return classModelObj
    }
    
    func insertStudent() -> Student{
        let student = Student(context: context)
        student.studentID = "1301024"
        return student
    }
    
    // MARK: - Core Data
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error encoding data \(error)")
        }
    }
}

