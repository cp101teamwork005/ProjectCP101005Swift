//
//  TeacherAccountAddTeacherViewController.swift
//  ProjectCP101005Swift
//
//  Created by 楊文興 on 2018/7/26.
//  Copyright © 2018年 楊文興. All rights reserved.
//

import UIKit

class TeacherAccountAddStudnetViewController: UIViewController {

    let communicator = CommunicatorWenSing()
    
    @IBOutlet weak var enterAccountLable: UITextField!
    @IBOutlet weak var enterNameLabel: UITextField!
    @IBOutlet weak var enterPasswordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //新增學生按鈕
    @IBAction func addStudentBtnPressed(_ sender: Any) {
        
        creatStudent()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func creatStudent() {//還沒改完
        //ACTION_ADD_STUDENT :action
        
        guard let name = enterNameLabel.text,
            let account = enterAccountLable.text,
            let password = enterPasswordLabel.text else {
                assertionFailure("invalid input value")
                return
        }
        let classId = "5"//用userDefault 的classID
        
//        let studentAccount = AddStudent(Student_ID: account, Student_Password: password, Student_Name: name, Class_Name: classId)
        
//        let action = AddNewStudentAccount(action: ACTION_ADD_STUDENT, id: studentAccount)
        let action = AddNewStudentAccount(action: ACTION_ADD_STUDENT, Student_ID: account, Student_Password: password, Student_Name: name, Class_Name: classId )
        print("\(action)")
        let econder = JSONEncoder()
        econder.outputFormatting = .init()
        guard let uploadData = try? JSONEncoder().encode(action) else {
            return
        }
        
        communicator.doPost(url: STUDENT_ACCOUNT_SERVLET, data: uploadData) { (result) in
            
            guard let result = result,let jsonIn = (try? JSONSerialization.jsonObject(with: result, options: [] )) as? [String:Int] else {
                return
            }
            
            self.dismiss(animated: false, completion: nil)
//            guard let dogId = jsonIn["dogId"] else {
//                return
//            }
            
//            UserDefaults.standard.set(dogId, forKey: "dogId")
            
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}