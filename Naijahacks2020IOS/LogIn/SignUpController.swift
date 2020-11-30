//
//  SignUpController.swift
//  Naijahacks2020IOS
//
//  Created by Ibrahim Momoh on 11/29/20.
//

import UIKit
import Parse

class SignUpController: UIViewController {

   
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var re_passwordField: UITextField!
    
    @IBOutlet var errorField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUserUp(_ sender: Any) {
        
        if checkifSamePassword() {
            
            let user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            user.email = emailField.text
            let sv = UIViewController.displaySpinner(onView: self.view)
          
            user.signUpInBackground { (success, error) in
                    UIViewController.removeSpinner(spinner: sv)
                    if success{
                        self.loadHomeScreen()
                    }else{
                        if let descrip = error?.localizedDescription{
                            self.displayErrorMessage(message: descrip)
                        }
                    }
                }
            
            
        }
        
        
    }
    
    
    func checkifSamePassword()-> Bool{
        guard let user = usernameField.text, !user.isEmpty else {
            errorField.isHidden = false
            errorField.text = "please enter username"
            return false
        }
        guard let email = emailField.text, !email.isEmpty else {
            errorField.isHidden = false
            errorField.text = "please enter email"
            return false
        }
        guard let firstPassword = passwordField.text, !firstPassword.isEmpty else {
            errorField.isHidden = false
            errorField.text = "please enter password"
            return false}
        guard let secondPassword = re_passwordField.text, !secondPassword.isEmpty else {
            errorField.isHidden = false
            errorField.text = "please re enter password"
            return false}
        
        
        if firstPassword == secondPassword {
            return true
        }
        errorField.isHidden = false
        errorField.text = "make sure both passwords are equal"
        return false
    }
    
    func loadHomeScreen(){
        
        performSegue(withIdentifier: "toFeedFromSignUp", sender: nil)
        
        
        
        
    }
    
    func displayErrorMessage(message: String){
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertView.addAction(OKAction)
            if let presenter = alertView.popoverPresentationController {
                presenter.sourceView = self.view
                presenter.sourceRect = self.view.bounds
            }
            self.present(alertView, animated: true, completion:nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
