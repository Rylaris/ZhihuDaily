//
//  ArticleManager.swift
//  ZhihuDaily
//
//  Created by 温蟾圆 on 2021/3/6.
//

import Foundation
import Alamofire
import SwiftyJSON

struct TestStory: Codable {
    var title: String
    var hint: String
    var url: String
    var images: [String]
    var id: Int
}

private enum ZhihuAPI: String {
    case latest = "/news/latest"
}

class StoryManager {
    
    static let baseURL = "https://news-at.zhihu.com/api/3"
    
    static func getTodayStory(callback: @escaping ([TestStory]) -> ()) {
        AF.request(baseURL + ZhihuAPI.latest.rawValue).responseJSON { response in
            switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let decoder = JSONDecoder()
                    do {
                        let todayStory = try decoder.decode([TestStory].self, from: json["stories"].rawData())
                        callback(todayStory)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
