//
//  ViewController.swift
//  ZhihuDaily
//
//  Created by 温蟾圆 on 2021/3/6.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    lazy var storyTableView: UITableView = {
        return UITableView()
    }()
    
    private var stories = [TestStory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        StoryManager.getTodayStory { todayStories in
            self.stories = todayStories
            self.storyTableView.reloadData()
        }
    }
    
    func setupUI() {
        storyTableView.frame = view.frame
        view.addSubview(storyTableView)
        storyTableView.delegate = self
        storyTableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "storyCell")
        let story = stories[indexPath.row]
        cell.textLabel?.text = story.title
        cell.detailTextLabel?.text = story.hint
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.numberOfSections - indexPath.section <= 2 {
            // TODO: 加载更多数据
            print("load more data")
        }
    }
}
