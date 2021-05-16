//
//  activityData.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/05/17.
//

import Foundation

struct ActivityData {
    let activity: String?
    let description: String?
}

let activities: [ActivityData] = [
    ActivityData(activity: "음악 듣기", description: "가장 좋아하는 음악이 있나요?\n눈을 감고 음악을 들어보는건 어때요?"),
    ActivityData(activity: "산책 하기", description: "기분이 좋지 않을 때,\n그냥 바람을 쐬며 걷다보면 나아질때가 있어요"),
    ActivityData(activity: "취미 생활", description: "취미가 있나요?\n없다면 집중해서 할 만한 취미를 만들어보면 어떨까요?"),
    ActivityData(activity: "일기 쓰기", description: "오늘 좋지 않았던 일을 적으면서 훌훌 털어보아요!"),
    ActivityData(activity: "맛있는 음식 먹기", description: "가장 좋아하는 음식이 있다면,\n오늘 그 음식을 먹으며 스트레스를 풀어보아요!"),
    ActivityData(activity: "운동 하기", description: "운동 좋아하세요?\n운동하면 잡생각이 사라지는 효과가 있답니다!"),
    ActivityData(activity: "샤워 하기", description: "샤워하고 나오면 상쾌해서 기분이 좋아질거에요,\n몸의 피로를 풀어보아요!"),
    ActivityData(activity: "오렌지 껍질 벗기기", description: "오렌지에 있는 시트러스 향은 스트레스를 줄여준대요!"),
    ActivityData(activity: "명상 하기", description: "명상이 정말 하기 간단하면서도 마음을 평온하게 해준답니다!"),
    ActivityData(activity: "감사한 일 찾아보기", description: "저는 오늘 당신이 저를 찾아주셔서 감사해요"),
    ActivityData(activity: "식물 키우기", description: "식물을 하나 정성껏 키우다보면 마음이 따뜻해질거에요!"),
    ActivityData(activity: "다크 초콜릿 먹기", description: "스트레스 받을땐 다크 초콜릿만한 게 없답니다!"),
    ActivityData(activity: "한 가지 일만 하기", description: "너무 많은 것을 하고있지는 않은가요?\n충분히 열심히 하고 있어요 조금 쉬어도 돼요"),
    ActivityData(activity: "녹차 마시기", description: "녹차의 향과 맛이 당신을 기분 좋게 해줄거에요"),
    ActivityData(activity: "SNS 끊기", description: "혹시 SNS가 당신을 괴롭게 하고 있지는 않은가요?\nSNS 없이도 당신은 충분히 멋져요!"),
    ActivityData(activity: "종이 구기기", description: "종이에 기분 안좋은 일을 적고 맘껏 구겨서 버려볼까요!")
]
