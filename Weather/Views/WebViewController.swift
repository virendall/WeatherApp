//
//  WebViewController.swift
//  Weather
//
//  Created by Virender Dall on 02/09/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let string = """
            <h3>Welcome to the Weather App!</h3>
            <ul>
            <li>
            <p>You can add a city or location from map simply by clicking + button on home page. </p>
            </li>
            <li>
            <p>If you want to delete an exisiting city bookmark then click on edit and you can remove that bookmark.</p>
            </li>
            <li>
            <p>You can change the unit from setting by clicking on unit row.</p>
            </li>
            </ul>
            """
        webView.loadHTMLString(string, baseURL: nil)
    }

}
