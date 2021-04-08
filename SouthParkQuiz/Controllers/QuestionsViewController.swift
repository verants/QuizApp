//
//  QuestionsViewController.swift
//  SouthParkQuiz
//
//  Created by Антон Вербицкий on 07.04.2021.
//

import UIKit

class QuestionsViewController: UIViewController {

	@IBOutlet var questionLabel: UILabel!

	@IBOutlet var singleStackView: UIStackView!
	@IBOutlet var singleButtons: [UIButton]!

	@IBOutlet var multipleStackView: UIStackView!
	@IBOutlet var multipleLabels: [UILabel]!
	@IBOutlet var multipleSwitches: [UISwitch]!

	@IBOutlet var rangedStackView: UIStackView!
	@IBOutlet var rangedLabels: [UILabel]!
	@IBOutlet var rangedSlider: UISlider! {
		didSet {
			let answerCount = Float(currentAnswers.count - 1)
			rangedSlider.maximumValue = answerCount
			rangedSlider.value = answerCount / 2
		}
	}

	@IBOutlet weak var questionProgressView: UIProgressView!

	private let questions = Question.getQuestion()
	private var choosenAnswers: [Answer] = []
	private var currentAnswers: [Answer] {
		questions[questionIndex].answers
	}
	private var questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let resultsVC = segue.destination as! ResultsViewController
		resultsVC.choosenAnswers = choosenAnswers
	}

	@IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
		guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
		let currentAnswer = currentAnswers[buttonIndex]
		choosenAnswers.append(currentAnswer)
		nextQuestion()
	}

	@IBAction func multipleAnswerButtonPressed() {
		for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
			if multipleSwitch.isOn {
				choosenAnswers.append(answer)
			}
		}
		nextQuestion()
	}

	@IBAction func rangedAnswerButtonPressed() {
		let index = lrintf(rangedSlider.value)
		choosenAnswers.append(currentAnswers[index])
		nextQuestion()
	}
	

}

// MARK: - Private Methods

extension QuestionsViewController {
	private func setupUI() {
		// Hide stacks
		for stackView in [singleStackView, multipleStackView, rangedStackView] {
			stackView?.isHidden = true
		}

		// get current question
		let currentQuestion = questions[questionIndex]

		// Set current quewstion for question label
		questionLabel.text = currentQuestion.title

		// Calculate progress
		let totalProgress = Float(questionIndex) / Float(questions.count)

		// Set progress for progress view
		questionProgressView.setProgress(totalProgress, animated: true)

		// Set title for navigation bar
		title = "Вопрос № \(questionIndex + 1) из \(questions.count)"

		// Show stack corresponding to question type
		showCurrentAnswers(for: currentQuestion.type)

	}

	private func showCurrentAnswers(for type: ResponseType) {
		switch type {
		case .single:
			showSingleStackView(with: currentAnswers)
		case .multiple:
			showMultipleStackView(with: currentAnswers)
		case .ranged:
			showRangedStackView(with: currentAnswers)
		}
	}

	private func showSingleStackView(with answers: [Answer]) {
		singleStackView.isHidden = false

		for (button, answer) in zip(singleButtons, answers) {
			button.setTitle(answer.title, for: .normal)
		}
	}

	private func showMultipleStackView(with answers: [Answer]) {
		multipleStackView.isHidden = false

		for (label, answer) in zip(multipleLabels, answers) {
			label.text = answer.title
		}
	}

	private func showRangedStackView(with answers: [Answer]) {
		rangedStackView.isHidden = false
		rangedLabels.first?.text = answers.first?.title
		rangedLabels.last?.text = answers.last?.title
	}

	private func nextQuestion() {
		questionIndex += 1

		if questionIndex < questions.count {
			setupUI()
			return
		}

		performSegue(withIdentifier: "showResult", sender: nil)
	}
}
