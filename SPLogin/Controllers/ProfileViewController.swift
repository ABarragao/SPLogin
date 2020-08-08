//
//  ProfileViewController.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 03/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?{
        didSet{
            if user != nil{
                updateUserUI()
            }
            self.stopLoading()
        }
    }

    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dashboardStackView: UIStackView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loaderContainer: LoaderView!
    @IBOutlet weak var feedbackView: FeedbackView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var jobsSubview: SubView!
    @IBOutlet weak var backupSubview: SubView!
    @IBOutlet weak var reactivnessSubview: SubView!
    @IBOutlet weak var yellowCardSubview: SubView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.getToken() != nil {
            self.getUserInfos()
        }
        setUpView()
        NotificationCenter.default.registerToReachability(observer: self, selector: #selector(getUserWithLogout))
    }

    //MARK: getUserInfos
    @objc func getUserInfos(){
        self.startLoading()
        if UserDefaults.standard.getToken() != nil {
            APIManager.shared.getMe { (error, user) in
                self.user = user
            }
        }
    }
    
    @objc func getUserWithLogout(){
        self.startLoading()
        if UserDefaults.standard.getToken() != nil {
            APIManager.shared.getMe { (error, user) in
                if user != nil{
                    self.user = user
                }
                else{
                    self.logout(nil)
                }
            }
        }
        else{
            self.logout(nil)
        }
    }
    
    //MARK: UpdateUI
    private func setUpView(){
        DispatchQueue.main.async {
            let image = UIImage(named: "pin")?.withRenderingMode(.alwaysTemplate)
            self.locationButton.setImage(image, for: .normal)
            self.locationButton.tintColor = Theme.primaryColor
            self.locationButton.imageView?.contentMode = .scaleAspectFit
            self.headerView.addShadow()
            self.headerView.backgroundColor = Theme.secondaryColor
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let topAreaHeight = keyWindow?.safeAreaInsets.top ?? 0
            self.buttonTopConstraint.constant += topAreaHeight
            self.pictureTopConstraint.constant += topAreaHeight
        }
    }
    
    func updateUserUI(){
        DispatchQueue.main.async {
            self.nameLabel.text = self.user?.completeName
            self.addressLabel.text = self.user?.completeAddress
            self.feedbackView.setStars(self.user?.kpi?.feedbackAverage ?? 0)
            self.jobsSubview.body.text = "\(self.user?.kpi?.countJobsDone ?? 0)"
            self.backupSubview.body.text = "\(self.user?.kpi?.countJobsBackup ?? 0)"
            self.yellowCardSubview.body.text = "\(self.user?.kpi?.countYellowCard ?? 0)"
            self.reactivnessSubview.body.text = "\((self.user?.kpi?.reactivenessPercentage ?? 0) * 100)%"
        }
    }
    
    //MARK: Actions
    @IBAction func logout(_ sender: Any?) {
        self.user = nil
        DispatchQueue.main.async {
            CoreDataManager.shared.deleteAllData()
            CoreDataManager.shared.saveContext()
            UserDefaults.standard.removeToken()
            let loginVC = LoginViewController.init(delegate: self)
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func locate(_ sender: Any) {
        guard let address = self.user?.address?.exacteAddress else{
            return
        }
        let string = String.init(format: "https://maps.apple.com/?address=%@", address)
        let url = NSURL.init(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        UIApplication.shared.open(url! as URL, options:[:], completionHandler: nil)
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

extension ProfileViewController: LoginDelegate{
    func userDidLog(_ user:User) {
        self.user = user
    }
}
