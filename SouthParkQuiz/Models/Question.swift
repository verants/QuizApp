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

struct Answer: Hashable {
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
			return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравяться и всегда готовы помочь."
		case .cat:
			return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
		case .rabbit:
			return "Вам нравится все мягкое. Вы здоровы и полны энергии."
		case .turtle:
			return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
		}
	}

	var figure: String {
		switch self {
		case .dog:
			return "🐶"
		case .cat:
			return "🐱"
		case .rabbit:
			return "🐰"
		case .turtle:
			return "🐢"
		}
	}
	
}
