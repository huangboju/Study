//
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

struct Widget {

    /// 实心按钮
    static func generateDarkButton(with title: String?, target: Any?, action: Selector) -> QMUIButton {
        let y = SCREEN_HEIGHT - CELL_HEIGHT - TabBarHeight
        let button = QMUIButton(frame: CGRect(x: PADDING, y: y, width: BODY_WIDTH, height: CELL_HEIGHT))
        button.adjustsButtonWhenHighlighted = true
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = APPConfigCenter.app
        button.highlightedBackgroundColor = UIColor(r: 0, g: 168, b: 225) // 高亮时的背景色
        button.layer.cornerRadius = 4
        return button
    }
    
    static func getData(then: @escaping ([Question]) -> ()) {
        DispatchQueue.global().async {
            var questions: [Question] = []
            guard let dataFilePath = Bundle.main.path(forResource: "zquestions", ofType: "json") else { return }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: dataFilePath))
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard let items = json as? [String: [String]] else { return }
                for (key, value) in items {
                    questions.append(Question(text: key, images: value))
                }
            } catch let error {
                print(error)
            }
            questions.random()
            DispatchQueue.main.async {
                then(questions)
            }
        }
    }

    static func verifyAnswer(with question: String, answer: String) -> AnswerType {
        let answers = [
            "Granny Smith Apple": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/184020063_200x200.jpg",
            "Cottonelle Clean Care Bathroom Tissue (4 roll)": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/960054668_200x200.jpg",
            "Nature Valley Sweet and Salty Nut Almond": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/111200483_200x200.jpg",
            "Sargento Shredded Sharp Cheddar": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/960074698_200x200.jpg",
            "Chobani Greek Pineapple Yogurt": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/960049985_200x200.jpg",
            "Pepto Bismol Chewable Tablets": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/159150033_200x200.jpg",
            "Arrowhead Mountain Spring Water 6-pack": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/108200051_200x200.jpg",
            "365 Organic Thai Jasmine Rice": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/12172-4b0201a183fb047f2e46165c749d12ff.jpg",
            "Lemon": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/184080250_200x200.jpg",
            "Organic Garbanzo Beans": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/4654-aa6e38c59150b93266e6e7d92eb458da.jpg",
            "365 Organic Frosted Flakes Cereal": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/12215-eaac44d114cb00be4e3ecc26e0cf39be.jpg",
            "Safeway Farms Sliced White Mushroom": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/960073826_200x200.jpg",
            "White Corn Tortilla Chips": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/4380-ad56a1f7582f483ab0a4a0a900508f8d.jpg",
            "Foster Farms Chicken Breast Fillets": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/188300248_200x200.jpg",
            "Folgers Coffee Half Caffeine Medium": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/960017511_200x200.jpg",
            "Oroweat Multi-grain Bread": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/196052221_200x200.jpg",
            "Lucerne Reduced Fat Milk (64 oz)": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/136010126_200x200.jpg",
            "Sun-Dried Tomato Chicken Sausage": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/1238-52fbe159a8d96ee9774a7bd881387589.jpg",
            "Lucerne Large Eggs Grade AA 18 count": "https://d1dei6v1vlghw9.cloudfront.net/productimages/200x200/138350091_200x200.jpg",
            "Simply Organic Black Pepper": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/7320-7fa1cb652f0534dd7f6a73c72e058668.jpg",
            "Trader Joe's Gluten Free Ginger Snaps": "https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/5238-e8e8b4d2043f78192271b523a54ad0d6.jpg"
        ]
        if answer.isEmpty {
            return .unselected
        }
        return answers[question] == answer ? .correct : .wrong
    }

    static func storeUser(with nickName: String, answers: [Answer]) {

        let filePath = path

        let answerDict = answers.map {
            [
                "idx": $0.idx,
                "type": $0.type.rawValue
            ]
        }

        var array = NSArray(contentsOfFile: filePath) as? [[String: Any]] ?? []

        let item: [String: Any] =
            [
                "name": nickName,
                "answers": answerDict
            ]
        array.append(item)

        NSArray(array: array).write(toFile: filePath, atomically: true)
    }

    static func getUsers() -> [User] {
        var data: [User] = []

        let filePath = path

        guard let users = NSArray(contentsOfFile: filePath) as? [[String: Any]] else { return data }

        for dict in users {
            let name = dict["name"] as? String ?? ""
            let answerDict = dict["answers"] as? [[String: Any]] ?? []
            let answers = answerDict.map {
                Answer(idx: $0["idx"] as? Int ?? 0, type: AnswerType(rawValue: $0["type"] as? String ?? "unselected") ?? .unselected)
            }

            data.append(User(nickName: name, answers: answers))
        }
        return data
    }
    
    private static var path: String {
        return NSHomeDirectory() + "/Documents/users.plist"
    }
}
