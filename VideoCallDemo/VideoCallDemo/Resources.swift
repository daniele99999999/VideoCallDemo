//
//  Resources.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation
import UIKit

public enum Resources {

    public enum Api {
        static let baseURL = URL(string: "https://www.google.com")!
    }
    public enum Keychain {
        static let accessKey = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        public enum Token {
            static let valueKey = "Token"
        }
    }
    public enum UI {
        public enum Colors {
            static let colorC8C8C8: UIColor = UIColor.init(hex: 0xC8C8C8)!
            static let colorFFFFFF: UIColor = UIColor.init(hex: 0xFFFFFF)!
            static let color000000: UIColor = UIColor.init(hex: 0x000000)!
            static let color6464AF: UIColor = UIColor.init(hex: 0x6464AF)!
        }
        public enum Fonts {
            static func systemRegular(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size) }
            static func systemBold(size: CGFloat) -> UIFont { return UIFont.boldSystemFont(ofSize: size) }
            static func systemItalic(size: CGFloat) -> UIFont { return UIFont.italicSystemFont(ofSize: size) }
        }
        public enum Placeholders {
            static let labelValue: String = "<Empty>"
        }
        public enum Appearance {
            static func navBar() {
                
                UINavigationBar.appearance().tintColor = Resources.UI.Colors.color000000
                UINavigationBar.appearance().backgroundColor = Resources.UI.Colors.colorFFFFFF
                UINavigationBar.appearance().isTranslucent = false
                
                if #available(iOS 15, *)
                {
                    let navigationBarAppearance = UINavigationBarAppearance()
                    navigationBarAppearance.configureWithOpaqueBackground()
                    UINavigationBar.appearance().tintColor = Resources.UI.Colors.color000000
                    UINavigationBar.appearance().backgroundColor = Resources.UI.Colors.colorFFFFFF
                    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                    UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    UINavigationBar.appearance().compactScrollEdgeAppearance = navigationBarAppearance
                }
            }
        }
    }
    
    enum Layout {
        enum Root {
            static let horizontalInsets: CGFloat = 64
        }
        
        enum Login {
            static let horizontalInsets: CGFloat = 64
            static let topInset: CGFloat = 20
        }
        
        enum Contacts {
            static let topInset: CGFloat = 20
            static let verticalPadding: CGFloat = 20
            static let horizontalInsets: CGFloat = 64
            enum Table {
                static let horizontalInsets: CGFloat = 16
            }
            enum Cell {
                static let horizontalInsets: CGFloat = 16
                static let verticalsInsets: CGFloat = 16
                static let itemHeight: CGFloat = 80
                static let itemSpacing: CGFloat = 16
            }
        }
        enum Call {
            static let horizontalInsets: CGFloat = 2
            static let verticalInsets: CGFloat = 2
            static let horizontalPadding: CGFloat = 2
            static let verticalPadding: CGFloat = 2
            enum Preview {
                static let horizontalInsets: CGFloat = 16
                static let verticalsInsets: CGFloat = 16
                static let aspectRatio: CGFloat = 1
                static let widthContainerRatio: CGFloat = 0.33
                static let padding: CGFloat = 2
            }
        }
    }
}

