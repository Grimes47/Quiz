//
//  ViewController.swift
//  Quiz
//
//  Created by Adam Hogan on 5/30/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    let questions: [String] = [
        "What is  7 + 7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"]
    
    let answers: [String] = [
    "14",
    "Montpelier",
    "Grapes"]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        // Do any additional setup after loading the view, typically from a nib.
        nextQuestionLabelCenterXConstraint.isActive = false
//        updateOffScreenLabel()
        let spaceBetweenLabels = UILayoutGuide()
        self.view.addLayoutGuide(spaceBetweenLabels)
        spaceBetweenLabels.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        nextQuestionLabel.centerXAnchor.constraint(equalTo: spaceBetweenLabels.leadingAnchor).isActive = true
        currentQuestionLabel.centerXAnchor.constraint(equalTo: spaceBetweenLabels.trailingAnchor).isActive = true
        
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateLabelTransitions() {
        // force any outstanding layout changes to occur
        view.layoutIfNeeded()
        //Animate the alpha
        // and the center x constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animate(withDuration: 1.0,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    options: [.curveEaseInOut],
                    animations: {
                        self.currentQuestionLabel.alpha = 0;
                        self.nextQuestionLabel.alpha = 1;
            
                        self.view.layoutIfNeeded()},
                    completion: { _ in
//                        swap (&self.currentQuestionLabel, &self.nextQuestionLabel)
//                        swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
//        
//                        self.updateOffScreenLabel()})
                        self.currentQuestionLabel.text = self.nextQuestionLabel.text
                        self.currentQuestionLabel.alpha = 1
                        self.currentQuestionLabelCenterXConstraint.constant = 0
                        self.view.layoutIfNeeded()
                        self.nextQuestionLabel.alpha = 0
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }

}

