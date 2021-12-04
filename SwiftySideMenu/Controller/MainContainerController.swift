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
//  ContainerController.swift
//  SwiftyCartV1
//
//  Created by GIJoeCodes on 12/1/21.
//

import UIKit

class ContainerController: UIViewController {
    
    var mainNavigationController: UINavigationController?
    let menuController = MenuController()
    let homeController = HomeController()
    var destination = UIViewController()
    var currentIndex = 0
    
    private var menuState: MenuState = .closed

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        addChildControllers()
    }
    
    private func addChildControllers() {
        // Add Menu Controller
        addChild(menuController)
        view.addSubview(menuController.view)
        menuController.didMove(toParent: self)
        menuController.delegate = self
        
        // Add Featured (Home) Controller
        let navigationController = UINavigationController(rootViewController: homeController)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        self.mainNavigationController = navigationController
        homeController.delegate = self
    }
    
    private func handleMenuTap(index: Int) {
        
        switch index {
        case MenuOption.home:
            resetViews(currentController: nil)
            homeController.navigationItem.title = NSLocalizedString("menu_title_home", comment: "")
            
        default:
            getController(option: index)
        }
        
        resetViews(currentController: destination)
        toggleMenu(completion: nil)
        
    }
    
    private func getController(option: Int) {
        guard let controller = Constants.menuOptions[option].controller else { return }
        destination = controller
        currentIndex = option
        homeController.navigationItem.title = Constants.menuOptions[option].title
    }
    
    private func toggleMenu(completion: (() -> Void)?) {
        
        let animation: UIView.AnimationOptions = .curveEaseInOut
        
        switch menuState {
        case .closed:
            // open menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: animation) { [self] in
                mainNavigationController?.view.frame.origin.x = Constants.screenWidth * 0.66
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleContainerTap(_:)))
                destination.view.isUserInteractionEnabled = true
                destination.view.addGestureRecognizer(tap)
                
                if resizeMenuContainer {
                    mainNavigationController?.view.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                }
                
                menuController.resizeTableView(sizeToDefault: true)
                
            } completion: { [weak self] completed in
                if completed {
                    self?.menuState = .opened
                }
            }
            
        case .opened:
            // close menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: animation) {
                self.mainNavigationController?.view.frame.origin.x = resizeMenuContainer ? Constants.screenWidth * 0.125 : 0
                if resizeMenuContainer {
                    self.mainNavigationController?.view.transform = CGAffineTransform.identity
                }
                self.menuController.resizeTableView(sizeToDefault: false)
                
            } completion: { [weak self] completed in
                if completed {
                    self?.menuState = .closed
                }
            }
            
        }
        
    }
    
    private func resetViews(currentController: UIViewController?) {
        
        let lazyControllers = [
            Constants.menuOptions[MenuOption.cart].controller,
            Constants.menuOptions[MenuOption.orders].controller,
            Constants.menuOptions[MenuOption.account].controller,
            Constants.menuOptions[MenuOption.about].controller,
            Constants.menuOptions[MenuOption.support].controller
        ]
        
        let controllers = lazyControllers.filter { $0 != currentController }
        for controller in controllers {
            guard let controller = controller else { return }
            if controller.view != nil {
                controller.view.removeFromSuperview()
                controller.didMove(toParent: nil)
            }
        }
        
        guard let controller = currentController else { return }
        homeController.addChild(controller)
        homeController.view.addSubview(controller.view)
        controller.view.frame = view.frame
        controller.didMove(toParent: homeController)
        
    }
    
    @objc
    private func handleContainerTap(_ sender: UITapGestureRecognizer) {
        print(currentIndex)
        handleMenuTap(index: currentIndex)
    }

}

extension ContainerController: FEFeaturedControllerDelegate {
    
    func didTapMenuButton() {
        handleMenuTap(index: 0)
    }
    
}

extension ContainerController: MenuControllerDelegate {
    
    func didSelect(index: Int) {
        handleMenuTap(index: index)
    }

}

