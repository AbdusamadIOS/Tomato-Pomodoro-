//
//  FinishVC.swift
//  Tomato (Pomodoro)
//
//  Created by Abdusamad Mamasoliyev on 30/04/24.
//

import UIKit
import AVFoundation

class FinishVC: UIViewController {
    
    let workLabel = UILabel()
    let timeLabel = UILabel()
    let startButton = UIButton()
    let cancelButton = UIButton()
    
    var player: AVAudioPlayer?
    var timer = Timer()
    var isTimerStarted = false
    var time = 25
    var mainTimeLabel: String = "25"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        navBar()
        let sum = (Int(mainTimeLabel) ?? 25) * 60
        time = sum
        print(time)
    }
    
    func navBar() {
        let setting = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(settingPress))
        setting.tintColor = UIColor(named: "textRed")
        navigationItem.leftBarButtonItem = setting
    }
    
    @objc func settingPress() {
        let set = SettingVC()
        navigationController?.pushViewController(set, animated: true)
    }
    
    func style() {
        view.backgroundColor = UIColor(named: "bgRed")
        navigationController?.navigationBar.tintColor = UIColor.textGreen
        
        workLabel.translatesAutoresizingMaskIntoConstraints = false
        workLabel.textColor = UIColor(named: "textRed")
        workLabel.text = "Work"
        workLabel.font = UIFont.systemFont(ofSize: 30)
        workLabel.textAlignment = .center
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.systemFont(ofSize: 112, weight: .black)
        timeLabel.text = "\(mainTimeLabel):00"

        timeLabel.textColor = UIColor(named: "textRed")
        timeLabel.textAlignment = .center
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Play", for: .normal)
        startButton.backgroundColor = UIColor(named: "btnRed")
        startButton.setTitleColor(UIColor(named: "textRed"), for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        startButton.layer.cornerRadius = 30
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Reset", for: .normal)
        cancelButton.backgroundColor = UIColor(named: "btnRed")
        cancelButton.setTitleColor(UIColor(named: "textRed"), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        cancelButton.layer.cornerRadius = 30
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
    }
    
    func layout() {
        view.addSubview(workLabel)
        view.addSubview(timeLabel)
        view.addSubview(startButton)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            workLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -10),
            workLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            workLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            
            cancelButton.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
            cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60)
        ])
    }
    
    @objc func startButtonTap() {
        
        let sum = (Int(mainTimeLabel) ?? 25) * 60
        time = sum
        print(time)
        cancelButton.isEnabled = true
        cancelButton.alpha = 1.0
        if !isTimerStarted {
            
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor(named: "textRed"), for: .normal)
            
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor(named: "textRed"), for: .normal)
        }
    }
    
    @objc func cancelButtonTap() {
        
        let sum = (Int(mainTimeLabel) ?? 25) * 60
        time = sum
        print(time)
        
        cancelButton.isEnabled = false
        cancelButton.alpha = 0.5
        timer.invalidate()
        time = sum
        isTimerStarted = false
        timeLabel.text = "\(mainTimeLabel):00"
        workLabel.text = "Work"
        startButton.isEnabled = true
        startButton.alpha = 1
        startButton.setTitle("Play", for: .normal)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        time -= 1
        timeLabel.text = formatTime(time)
        
        if timeLabel.text == "00:00" {
            timer.invalidate()
            playSound("ting")
            workLabel.text = "Break"
            startButton.isEnabled = false
            startButton.alpha = 0.5
        }
    }
    
    func formatTime(_ time: Int)->String{
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func playSound(_ name: String) {
        
        let url = Bundle.main.url(forResource: name, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
