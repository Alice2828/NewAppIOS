//
//  UIApplication.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 10.12.2021.
//

import Foundation
import UIKit

extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }
