//
//  SettingVC.swift
//  Tomato (Pomodoro)
//
//  Created by Abdusamad Mamasoliyev on 29/04/24.
//

import UIKit

class SettingVC: UIViewController {
    
    let workLabel = UILabel()
    let workLabel2 = UILabel()
    let workTimeLabel = UILabel()
    let workSlider = UISlider()
    let changedButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    func style() {
        view.backgroundColor = UIColor(named: "bgGreen")
        navigationController?.navigationBar.tintColor = UIColor.textGreen
        
        workLabel.translatesAutoresizingMaskIntoConstraints = false
        workLabel.textColor = UIColor(named: "textGreen")
        workLabel.text = "Work"
        workLabel.font = UIFont.systemFont(ofSize: 30)
        workLabel.textAlignment = .center
        
        workTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        workTimeLabel.textColor = UIColor(named: "textGreen")
        workTimeLabel.font = UIFont.systemFont(ofSize: 112, weight: .black)
        workTimeLabel.textAlignment = .center
        workTimeLabel.text = "25:00"
        
        workLabel2.translatesAutoresizingMaskIntoConstraints = false
        workLabel2.textColor = UIColor(named: "textGreen")
        workLabel2.text = "Work"
        
        workSlider.translatesAutoresizingMaskIntoConstraints = false
        workSlider.minimumValue = 1
        workSlider.maximumValue = 99
        workSlider.value = 25
        workSlider.isContinuous = true
        workSlider.tintColor = UIColor(named: "btnGreen")
        workSlider.addTarget(self, action: #selector(workPress), for: .valueChanged)
        
        changedButton.translatesAutoresizingMaskIntoConstraints = false
        changedButton.setTitle("Changed", for: .normal)
        changedButton.setTitleColor(UIColor(named: "textGreen"), for: .normal)
        changedButton.backgroundColor = UIColor(named: "btnGreen")
        changedButton.layer.cornerRadius = 30
        changedButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        changedButton.addTarget(self, action: #selector(changedButtonTap), for: .touchUpInside)
        
    }
    
    func layout() {
        view.addSubview(workLabel)
        view.addSubview(workTimeLabel)
        view.addSubview(workLabel2)
        view.addSubview(workSlider)
        view.addSubview(changedButton)
        
        NSLayoutConstraint.activate([
            
            workLabel.bottomAnchor.constraint(equalTo: workTimeLabel.topAnchor, constant: -10),
            workLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            workTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workTimeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            workTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workTimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            workLabel2.bottomAnchor.constraint(equalTo: workSlider.topAnchor, constant: -10),
            workLabel2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workLabel2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            workSlider.bottomAnchor.constraint(equalTo: changedButton.topAnchor, constant: -60),
            workSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                        
            changedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            changedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            changedButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            changedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func workPress(_ sender: UISlider) {
        let workSlider = String(format: "%.0f", sender.value)
        let workSliderInt = Int(workSlider)
        if workSliderInt! < 10 {
            workTimeLabel.text = "0\(workSlider):00"
        } else {
            workTimeLabel.text = "\(workSlider):00"
        }
    }
    @objc func changedButtonTap() {
        
        let finish = FinishVC()
        finish.mainTimeLabel = String(workTimeLabel.text?.prefix(2) ?? "25")
        navigationController?.pushViewController(finish, animated: true)
    }
}
