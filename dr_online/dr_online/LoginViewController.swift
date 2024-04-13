//
//  ViewController.swift
//  dr_online
//
//  Created by Jayanth on 2/19/24.
//

import UIKit
import Lottie
import FirebaseAuth
import AnimatedGradientView

class LoginViewController: UIViewController {

    @IBOutlet weak var LaunchLAV: LottieAnimationView!{
        didSet{
            LaunchLAV.animation = LottieAnimation.named("Animation_app")
            LaunchLAV.alpha = 1
            LaunchLAV.play{ [weak self] _ in
                       UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                            self?.LaunchLAV.alpha = 0.0
                        }
                    }
                }
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func loginbutton(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error != nil {
                self?.alert(message: "Invalid Username/ Password. Try Again")
            } else {
                print("reached here")
                self?.performSegue(withIdentifier: "homescreensegue", sender: nil)
            }
        }
    }
    
    @IBAction func forgetpassword(_ sender: Any) {
        guard let email = emailTF.text, !email.isEmpty else {
                    alert(message: "enter email address.")
                    return
                }

                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        // Handle password reset error
                        print("Password reset error: \(error.localizedDescription)")
                    } else {
                        // Password reset email sent successfully
                        self.alert(message: "Password reset email sent successfully")
                    }
                }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applygradient()// Do any additional setup after loading the view.
    }
    
    private func alert(message : String){
        let alert = UIAlertController(title: "Password", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (action) in
        })
        present(alert, animated: true, completion: nil)
    }
    private func applygradient(){
        let gradientType: CAGradientLayerType = .axial
        let direction: AnimatedGradientViewDirection = .down
        let animatedGradient = AnimatedGradientView(frame: self.view.bounds)
        animatedGradient.animationValues = [
            (colors: ["#F3DCBE","cc2b5e"],direction,gradientType),
                        (colors: ["#F3D2D6","bdc3c7"],direction,gradientType),
                        (colors: ["de6262","dd5e89"],direction,gradientType),
                        (colors: ["#E9F3F2","2193b0"],direction,gradientType),
        ]
        self.view.insertSubview(animatedGradient, at:0)
    }


}

