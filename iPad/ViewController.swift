//
//  ViewController.swift
//  iPad
//
//  Created by 曾昊 on 2022/11/3.
//

import UIKit


var popupWindow: UIWindow?

class FadeWindow: UIWindow {
    override func makeKeyAndVisible() {
        super.makeKeyAndVisible()
        self.alpha = 0
        UIView.animate(withDuration: 0.24) {
            self.alpha = 1
        }
    }
}


class ViewController1: UIViewController {

    var gradient: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.gradient = CAGradientLayer()

        gradient?.frame = view.bounds
        gradient?.colors = [UIColor.green.cgColor, UIColor.yellow.cgColor]

        view.layer.insertSublayer(gradient!, at: 0)
    }
    
    @IBAction func show(_ sender: Any) {
        let windowScene = UIApplication.shared.connectedScenes.first
        if let windowScene = windowScene as? UIWindowScene {
            popupWindow = FadeWindow(windowScene: windowScene)
            popupWindow?.frame = UIScreen.main.bounds
            let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nav")
            nav.view.frame = UIScreen.main.bounds.inset(by: .init(top: 150, left: 150, bottom: 150, right: 150))
            let root = UIViewController()
            root.view?.backgroundColor = .black.withAlphaComponent(0.5)
            let options = UIWindow.TransitionOptions(direction: .fade, style: .easeInOut)
            options.background = UIWindow.TransitionOptions.Background.solidColor(UIColor.black)
            options.duration = 0.25

            popupWindow?.set(rootViewController: root, options: options, nil)
            root.addChild(nav)
            root.view.addSubview(nav.view)
            nav.didMove(toParent: root)
            popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
            popupWindow?.makeKeyAndVisible()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient?.frame = view.bounds
    }
    
}

class ViewController: UIViewController {
    
}
