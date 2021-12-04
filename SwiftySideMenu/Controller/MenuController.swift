//  MIT License
//
//  Copyright (c) 2021 GIJoeCodes
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  MenuController.swift
//  SwiftyCartV1
//
//  Created by GIJoeCodes on 12/3/21.
//

import UIKit

protocol MenuControllerDelegate: AnyObject {
    func didSelect(index: Int)
}

class MenuController: UIViewController {
    
    private let cellIdentifier = "cell"
    private let tableRowHeight: CGFloat = 58
    weak var delegate: MenuControllerDelegate?
    private let menuOptions = Constants.menuOptions
    
    // This allows you to initialize your custom UIViewController without a nib or bundle.
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTableView()
    }
    
    private func setupUI() {
        setupViewBackground()
    }
    
    private func setupViewBackground() {
        view.backgroundColor = .systemBackground
        view.layer.opacity = 0
        
        if resizeMenuController {
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        
        if addMenuBackground {
            guard let image = AppImages.menuBackground else { return }
            view.addBackground(image:image, opacity: 1.0, addBlurEffect: true)
        }
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: view.frame, style: .plain)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorColor = .clear
        view.contentInset = UIEdgeInsets(top: 0,left: 40,bottom: 0,right: 0)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.centerView(
            centerXAxis: view.centerXAnchor,
            paddingXAxis: Constants.screenWidth * 0.25,
            centerYAxis: view.centerYAnchor,
            paddingYAxis: 0,
            width: view.frame.width,
            height: CGFloat(menuOptions.count) * tableRowHeight
        )
        tableView.layoutIfNeeded()
    }
    
    func resizeTableView(sizeToDefault: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) { [self] in
                if sizeToDefault {
                    view.layer.opacity = 1.0
                    if resizeMenuController {
                        view.transform = CGAffineTransform.identity
                    }
                    view.layoutIfNeeded()
                    
                } else {
                    view.layer.opacity = 0
                    if resizeMenuController {
                        view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                    view.layoutIfNeeded()
                }
                
            } completion: { completed in
                //
            }
        }
    }

}

extension MenuController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        tableRowHeight
    }
}

extension MenuController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        var content = cell.defaultContentConfiguration()

        // Configure content.
        let option = menuOptions[indexPath.row]

        content.text = option.title
        content.image = option.image
        
        // Customize appearance.
        content.imageProperties.tintColor = .label

        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
