//
//  Question.swift
//  SouthParkQuiz
//
//  Created by Антон Вербицкий on 06.04.2021.
//

struct Question {
	let title: String
	let type: ResponseType
	let answers: [Answer]

	static func getQuestion() -> [Question] {
		[
			Question(
				title: "Какую пищу предпочитаете?",
				type: .single,
				answers: [
					Answer(title: "Стейк", type: .dog),
					Answer(title: "Рыба", type: .cat),
					Answer(title: "Морковь", type: .rabbit),
					Answer(title: "Кукуруза", type: .turtle)
				]
			),
			Question(
				title: "Что вам нравится больше?",
				type: .multiple,
				answers: [
					Answer(title: "Плавать", type: .dog),
					Answer(title: "Спать", type: .cat),
					Answer(title: "Обниматься", type: .rabbit),
					Answer(title: "Есть", type: .turtle)
				]
			),
			Question(
				title: "Любите ли вы поездки на машине?",
				type: .ranged,
				answers: [
					Answer(title: "Ненавижу", type: .cat),
					Answer(title: "Нервничаю", type: .rabbit),
					Answer(title: "Не замечаю", type: .turtle),
					Answer(title: "Обожаю", type: .dog)
				]
			),
		]
	}
}

struct Answer {
	let title: String
	let type: AnimalType
}

enum ResponseType {
	case single
	case multiple
	case ranged
}

enum AnimalType: Character {
	case dog = "🐶"
	case cat =  "🐱"
	case rabbit = "🐰"
	case turtle = "🐢"

	var definition: String {
		switch self {
		case .dog:
			return "You're dog"
		case .cat:
			return "You're cat"
		case .rabbit:
			return "You're rabbit"
		case .turtle:
			return "You're turtle"
		}
	}
}
