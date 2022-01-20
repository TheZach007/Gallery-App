//
//  LoginViewController.swift
//  Gallery-App
//
//  Created by Phincon on 20/01/22.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        checkField()
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setupView() {
        loginBtn.layer.cornerRadius = loginBtn.frame.height/2
        signupBtn.layer.cornerRadius = signupBtn.frame.height/2
        signupBtn.layer.borderWidth = 1
        signupBtn.layer.borderColor = UIColor.systemBlue.cgColor
        alertLabel.isHidden = true
    }
    
    func checkField() {
        if userField.text == "" && passField.text == "" {
            alertLabel.isHidden = false
            alertLabel.text = "Username and Password cannot be emptied!"
        } else {
//            let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
//            navigationController?.pushViewController(vc!, animated: true)
            checkData()
        }
    }
    
    func checkData()
    {
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
          let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Accounts")
        fetchRequest.predicate = NSPredicate(format: "email = %@", userField.text!)
        fetchRequest.predicate = NSPredicate(format: "password = %@", passField.text!)

          do {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
            navigationController?.pushViewController(vc!, animated: true)
          } catch {
            print(error)
            alertLabel.isHidden = false
            alertLabel.text = "Username and Password cannot be emptied!"
          }
    }

}
