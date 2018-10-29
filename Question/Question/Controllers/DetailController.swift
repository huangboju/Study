//
//  Copyright © 2017年 huangboju. All rights reserved.
//

import MTPopup

private let second = 120

class DetailController: BaseController {

    public var nickName: String?

    private var questions: [Question] = []
    private var answers: [Answer] = []
    private var currentIndex = 0
    fileprivate var currentSelectedAnswer = ""

    private var timer: DispatchSourceTimer?
    private var bodyView: BodyView!

    private lazy var nextBtn: QMUIButton = {
        let startBtn = Widget.generateDarkButton(with: "下一题", target: self, action: #selector(nextAction))
        return startBtn
    }()

    private lazy var timingLabel: UILabel = {
        let timingLabel = UILabel(frame: CGRect(x: PADDING, y: TopBarHeight, width: BODY_WIDTH, height: 44))
        timingLabel.textColor = APPConfigCenter.app
        timingLabel.textAlignment = .center
        timingLabel.font = UIFontBoldMake(17)
        return timingLabel
    }()

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        deinitTimer()
    }

    override func initUI() {

        if IS_DEBUG {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "重测", style: .plain, target: self, action: #selector(retryAction))
        }

        view.backgroundColor = .groupTableViewBackground

        view.addSubview(timingLabel)

        // 时间计数
        startTiming(with: timingLabel)

        view.addSubview(nextBtn)

        let y = timingLabel.frame.maxY
        bodyView = BodyView(frame: CGRect(x: 0, y: y, width: SCREEN_WIDTH, height: nextBtn.frame.minY - y))
        bodyView.delegate = self
        view.addSubview(bodyView)

        // TODO: 第一次在setBodyView中设置不行
        navigationItem.title = "第 1 题"

        // 读取数据
        Widget.getData { questions in
            self.questions = questions
            self.setBodyView()
        }
    }

    func nextAction() {
        // 下一题后，清空选中的答案
        defer { currentSelectedAnswer = "" }
        // 设置用户的答案
        setAnswer()

        let submitTitle = "提交"

        // 最后一题
        if nextBtn.currentTitle == submitTitle {
            disableButton(with: submitTitle)
            submit()
            return
        }

        currentIndex += 1
        setBodyView()
        if currentIndex == questions.count - 1 {
            nextBtn.setTitle(submitTitle, for: .normal)
        }
    }

    func retryAction() {
        nextBtn.setTitle("下一题", for: .normal)
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = APPConfigCenter.app

        startTiming(with: timingLabel)

        currentIndex = 0
        questions.random()
        setBodyView()
    }

    private func setBodyView() {
        bodyView.content = (questions[currentIndex], currentIndex)
        navigationItem.title = "第 \(currentIndex + 1) 题"
    }

    private func startTiming(with label: UILabel) {
        var _timeOut = second
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.scheduleRepeating(wallDeadline: .now(), interval: .seconds(1))
        timer?.setEventHandler {
            if _timeOut > 0 {
                label.text = "剩余\(_timeOut == second ? second : _timeOut % second)秒"
            } else {
                self.timeOut()
            }
            _timeOut -= 1
        }
        // 启动定时器
        timer?.resume()
    }

    private func deinitTimer() {
        timer?.cancel()
        timer = nil
    }

    private func disableButton(with title: String?) {
        nextBtn.setTitle(title, for: .disabled)
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = .lightGray
    }
    
    private func setAnswer() {
        let question = questions[currentIndex].text
        let type = Widget.verifyAnswer(with: question, answer: currentSelectedAnswer)
        let answer = Answer(idx: currentIndex + 1, type: type)
        answers.append(answer)
    }

    private func submit() {
        showAnswerController()

        guard let nickName = nickName else {
            return
        }
        Widget.storeUser(with: nickName, answers: answers)
    }
    
    private func timeOut() {
        timingLabel.text = "时间结束"
        timer?.cancel()
        disableButton(with: timingLabel.text)

        for i in answers.count + 1 ... questions.count {
            answers.append(Answer(idx: i, type: .unselected))
        }

        submit()
    }

    private func showAnswerController() {
        let vc = AnswersController()
        vc.answers = answers
        vc.title = nickName
        let popupController = MTPopupController(rootViewController: vc)
        popupController.present(in: self)
    }
}

extension DetailController: BodyViewDelegate {
    func didSelected(at idx: Int, with title: String) {
        currentSelectedAnswer = title
    }
}
