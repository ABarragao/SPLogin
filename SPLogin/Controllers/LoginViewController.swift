//
//  LoginViewController.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 02/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

protocol LoginDelegate {
    func userDidLog(_ user:User)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorView: ErrorView!
    @IBOutlet weak var errorBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loaderContainer: LoaderView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    var delegate: LoginDelegate!
    
    init(delegate: LoginDelegate){
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setUpView()
    }
    
    //MARK: UpdateUI
    private func setUpView(){
        self.loginBtn.backgroundColor = Theme.secondaryColor
        self.loginBtn.setTitle("login.cta".localized(), for: .normal)
        self.emailTxtField.tintColor = Theme.secondaryColor
        self.emailTxtField.placeholder = "login.username".localized()
        self.passwordTxtField.tintColor = Theme.secondaryColor
        self.passwordTxtField.placeholder = "login.password".localized()
        self.emailTxtField.delegate = self
        self.passwordTxtField.delegate = self
        self.loginBtn.disable()
    }

    private func setGradientBackground(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [Theme.primaryColor.cgColor,Theme.primaryColor.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: Action
    @IBAction func loginAction(_ sender: Any) {
        
        self.passwordTxtField.resignFirstResponder()
        self.emailTxtField.resignFirstResponder()
        
        startLoading()
        guard let email = emailTxtField.text, let password = passwordTxtField.text else{
            stopLoading()
            return
        }
        
        
        APIManager.shared.login(email: email, password: password) { (error,user) in
            self.stopLoading()
            if user != nil {
                DispatchQueue.main.async {
                    self.delegate.userDidLog(user!)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            else{
                if error == wsError.noInternet {
                    self.showNoInternetAlert()
                    return
                }
                self.showError()
            }
        }
    }
    
    //MARK: Error
    private func showNoInternetAlert(){
        let alert = UIAlertController.getNoInternetAlert()
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showError(){
        DispatchQueue.main.async {
            self.errorBottomConstraint.constant = 50
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                self.errorView.shake()
            })
            
        }
    }
    
    private func hideError(){
        let constant = CGFloat(-200)
        
        if(self.errorBottomConstraint.constant != constant){
            DispatchQueue.main.async {
                self.errorBottomConstraint.constant = constant
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //MARK: Loader
    private func startLoading(){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.loaderContainer.startLoading()
            self.loaderContainer.isHidden = false
            
            UIView.animate(withDuration: 0.5) {
                self.loaderContainer.alpha = 1
            }
        }
    }
    
    private func stopLoading(){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.loaderContainer.stopLoading()
            self.loaderContainer.isHidden = true
            self.loaderContainer.alpha = 0
        }
    }
}

extension LoginViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideError()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTxtField{
            self.passwordTxtField.becomeFirstResponder()
        }
        else{
            self.passwordTxtField.resignFirstResponder()
        }
        
        if(self.emailTxtField.text?.count ?? 0 > 0 && self.passwordTxtField.text?.count ?? 0 > 0){
            self.loginBtn.enable()
        }
        else{
            self.loginBtn.disable()
        }
        return true
    }
}
