//
//  NextVC.swift
//  EnvironmentDemo
//
//  Created by Rath! on 7/6/24.
//

import UIKit

class NextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImageView(frame: view.bounds)
        view.addSubview(img)
        img.image = .image
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: view.topAnchor),
            img.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            img.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            img.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        view.backgroundColor = .white
        let buttom = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        buttom.backgroundColor  = .red
        buttom.setTitle("Ok One", for: .normal)
        buttom.addTarget(self, action: #selector(tappedNext), for: .touchUpInside)
        view.addSubview(buttom)
        // Do any additional setup after loading the view.
        
        
        let buttom1 = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 50))
        buttom1.backgroundColor  = .orange
        buttom1.setTitle("Ok", for: .normal)
        buttom1.addTarget(self, action: #selector(tappedNextOne), for: .touchUpInside)

        view.addSubview(buttom1)
        

    }
    

    @objc func tappedNext (){
  
            let vc = ViewController()
            vc.isPunchcard = true
            navigationController?.pushViewController(vc, animated: true)
   
    }

    
    @objc func tappedNextOne (){
  
            let vc = ViewController()
        vc.isPunchcard = false
            navigationController?.pushViewController(vc, animated: true)
   
    }

}
