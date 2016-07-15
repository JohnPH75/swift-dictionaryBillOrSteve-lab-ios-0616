//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    
    @IBOutlet weak var scoreCounter: UILabel!
    
    @IBOutlet weak var billButton: UIButton!
    
    @IBOutlet weak var steveButton: UIButton!
    
    //instance variable to store billAndSteveFacts
    var billAndSteveFacts: [String:[String]] = [:]
    
    func createFacts() {
        billAndSteveFacts["Steve Jobs"] = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
            "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
            "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
            "He was a pescetarian, meaning he ate no meat except for fish."
        ]
        billAndSteveFacts["Bill Gates"] = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
            "He scored 1590 (out of 1600) on his SATs.",
            "His foundation spends more on global health each year than the United Nation's World Health Organization.",
            "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
            "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFacts()
        
        showFact()
    }

    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
    func getRandomFact() -> (String,String)? {
        
        var billOrSteve = randomPerson()
        
        let steveFacts = billAndSteveFacts["Steve Jobs"]?.count
        let billFacts = billAndSteveFacts["Bill Gates"]?.count
        
        if steveFacts == 0 && billFacts == 0 {
            return nil
        }
            
        else if steveFacts == 0 {
            billOrSteve = "Bill Gates"
        }
            
        else if billFacts == 0 {
            billOrSteve = "Steve Jobs"
        }
        
        if let facts = billAndSteveFacts[billOrSteve] {
            
            let factNumber = randomNumberFromZeroTo(facts.count)
            
            return (billOrSteve, facts[factNumber])
        }
        else {
            
            print("No facts found for \(billOrSteve)")
            
            return nil
        }
    }
    
    var scoreCount = 0
    
    @IBAction func steveButton(sender: AnyObject) {
        if var facts = billAndSteveFacts["Steve Jobs"] {
            if let factInWorks = factLabel.text {
                for fact in facts{
                    if fact == factInWorks {
                        scoreCount += 1
                        break;
                    }
                }
                if let index = facts.indexOf(factInWorks) {
                    facts.removeAtIndex(index)
                    billAndSteveFacts["Steve Jobs"] = facts
                }
                else {
                    if let index = billAndSteveFacts["Bill Gates"]?.indexOf(factInWorks) {
                        billAndSteveFacts["Bill Gates"]?.removeAtIndex(index)
                    }
                }
                scoreCounter.text = String(scoreCount)
                
                showFact()
            }
        }
    }
    
    @IBAction func billButton(sender: AnyObject) {
        if var facts = billAndSteveFacts["Bill Gates"] {
            if let factInWorks = factLabel.text {
                for fact in facts{
                    if fact == factInWorks {
                        scoreCount += 1
                        break;
                    }
                }
                if let index = facts.indexOf(factInWorks) {
                    facts.removeAtIndex(index)
                    billAndSteveFacts["Bill Gates"] = facts
                }
                else {
                    if let index = billAndSteveFacts["Steve Jobs"]?.indexOf(factInWorks) {
                        billAndSteveFacts["Steve Jobs"]?.removeAtIndex(index)
                    }
                }
                scoreCounter.text = String(scoreCount)
                
                showFact()
            }
        }
    }
    
    func showFact() {
        if let fact: (person:String, factString:String) = getRandomFact() {
            factLabel.text = fact.factString
        }
        else {
            factLabel.text = ""
        }
    }
    
}
