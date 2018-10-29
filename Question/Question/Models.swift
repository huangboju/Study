//
//  Copyright © 2017年 huangboju. All rights reserved.
//

struct Question {
    let text: String
    let images: [String]
}

struct Answer {
    // 题号
    let idx: Int
    let type: AnswerType
}

struct User {
    let nickName: String
    let answers: [Answer]
}
