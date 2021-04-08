//
//  ResultsViewController.swift
//  SouthParkQuiz
//
//  Created by Антон Вербицкий on 07.04.2021.
//

import UIKit

class ResultsViewController: UIViewController {

	@IBOutlet var answerLabel: UILabel!
	@IBOutlet var answerDescriptionLabel: UILabel!

	var choosenAnswers: [Answer]!


    override func viewDidLoad() {
        super.viewDidLoad()

		// находим самый частовстречающийся элемент массива
		self.navigationItem.setHidesBackButton(true, animated: false)

		getResult()
	}

	// находим самый частовстречающийся элемент массива
	private func mostFrequent<T: Hashable>(array: [T]) -> (value: T, count: Int)? {

		let counts = array.reduce(into: [:]) { $0[$1, default: 0] += 1 }

		if let (value, count) = counts.max(by: { $0.1 < $1.1 }) {
			return (value, count)
		}
		return nil
	}

	// выводим результат
	private func getResult() {

		let result = mostFrequent(array: choosenAnswers)
		answerLabel.text = "Вы - \(result?.value.type.figure ?? "")"
		answerDescriptionLabel.text = result?.value.type.definition
	}

}
