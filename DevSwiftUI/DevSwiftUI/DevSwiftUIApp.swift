//
//  DevSwiftUIApp.swift
//  DevSwiftUI
//
//  Created by Nojood Aljuaid  on 20/11/1444 AH.
//

import SwiftUI
import FirebaseCore
import Firebase


@main
struct DevSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
