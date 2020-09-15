//  ViewController.swift
//  guess_number
//  Created by Pincheng Huang on 2020/9/9.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var totalTime = Int()
    var lifeCount = 6 // 一局有 6 條命
    
    // 提示數字區間
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    
    // 顯示秒數
    @IBOutlet weak var timeLabel: UILabel!
    
    // 顯示還可猜幾次
    @IBOutlet weak var lifeLabel: UILabel!
    
    // 文字提示
    @IBOutlet weak var hint: UILabel!
    
    // 讓玩家輸入數字
    @IBOutlet weak var Input: UITextField!
    
    // 暫設來顯示亂數產生的答案
    @IBOutlet weak var answer: UITextField!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        timer.invalidate() // 停止計時
        Input.text = ""
        hiddenAnswer() // 執行 亂數產生一組 答案數字
        timer = Timer()
        totalTime = Int()
        timerStart() // 計時開始
        lifeLabel.text = "\(lifeCount)"
        
        
    }
    
    // 點擊鍵盤外的區域，即可收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // 產生一組亂數
    func hiddenAnswer() {
        let number = Int.random(in: 1...99) // 在 0 到 99 的區間中，產生一個亂數
        answer.text = "\(number)" // 暫時將答案顯示出來
        lifeCount = 6 // 重新計算一局有 6 條命
        min.text = "1"
        max.text = "99"
        
        
        }
    
    // 比較答案
    func compare(number: Int) {
        if number == Int(answer.text!) {
            hint.text = String("答對了")
            timer.invalidate() // 停止計時
            gameOver()
            
        } else if number >= Int(answer.text!)! {
            hint.text = String("你太大了喔")
            Input.text = "" // UI Text Field 清空
            if number >= Int(max.text!)! {
                max.text = max.text
            } else {
                max.text = "\(number)"
            }
            lifeCount -= 1
            lifeLabel.text = "\(lifeCount)"
            
        } else if number <= Int(answer.text!)! {
            hint.text = String("太小了…")
            Input.text = "" // UI Text Field 清空
            if number <= Int(min.text!)! {
                min.text = min.text
            } else {
                min.text = "\(number)"
            }
            
            lifeCount -= 1
            lifeLabel.text = "\(lifeCount)"
            
        }
        
    }
    
    @IBAction func inputGuess(_ sender: UITextField) {
        
        if lifeCount - 1 == 0, Input.text != nil {
            lifeLabel.text = "\(lifeCount)"
            gameOver()
            
            
        } else if Input.text! == "" { // 不執行任何程式，只是避免玩家未在 UI Text Field 輸入任何值而導致 app 閃退
        } else if Int(Input.text!) == nil { // 不執行任何程式，只是避免玩家未在 UI Text Field 輸入任何值而導致 app 閃退
        } else {
            let guessNumber = Int(sender.text!)!
            compare(number: guessNumber)
        }
    }
    
    
    func gameOver() {
        timer.invalidate() // 停止計時
        let gameOverAlert = UIAlertController(title: "Game Over", message: "正確答案是 \(String(answer.text!))", preferredStyle: .alert) // 設定遊戲結束的警告視窗，並顯示答案
        
        let replay = UIAlertAction(title: "再來一局", style: .default, handler: {(action:UIAlertAction) -> () in
            self.timer.invalidate() // 停止計時
            self.viewDidLoad()
            
            })
        
        gameOverAlert.addAction(replay) //將 replay 加入進 Alert 中
        self.present(gameOverAlert, animated: true, completion: nil)
        
    }
        
    
    //設定時間計數器
    func timerStart(){
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }

    @objc func updateTime(){
        totalTime += 1
        timeLabel.text = String(totalTime/60) + ":" + String(format:"%02d", totalTime%60)
    }
    

    
  
    

    



}
