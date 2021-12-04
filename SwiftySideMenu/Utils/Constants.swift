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
//  Constants.swift
//  SwiftyCartV1
//
//  Created by GIJoeCodes on 12/3/21.
//

import UIKit

struct Constants {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let menuOptions: [MenuOptionContent] = [
        MenuOptionContent(title: NSLocalizedString("menu_title_home", comment: ""), image: AppImages.menuOptionHome!, controller: nil),
        MenuOptionContent(title: NSLocalizedString("menu_title_cart", comment: ""), image: AppImages.menuOptionCart!, controller: CartController()),
        MenuOptionContent(title: NSLocalizedString("menu_title_orders", comment: ""), image: AppImages.menuOptionOrders!, controller: OrdersController()),
        MenuOptionContent(title: NSLocalizedString("menu_title_account", comment: ""), image: AppImages.menuOptionAccount!, controller: AccountController()),
        MenuOptionContent(title: NSLocalizedString("menu_title_about", comment: ""), image: AppImages.menuOptionAbout!, controller: AboutController()),
        MenuOptionContent(title: NSLocalizedString("menu_title_support", comment: ""), image: AppImages.menuOptionSupport!, controller: SupportController())
    ]

    
}




