//
//  AppDelegate.swift
//  Achievements
//
//  Created by Ivan C Myrvold on 22.12.2015.
//  Copyright © 2015 Ivan C Myrvold. All rights reserved.
//

import UIKit

enum Notifications {
    enum Categories: String {
        case MessageGoal
        case MessageResult
        case NoMessage
    }
    
    enum Actions: String {
        case LeaveAchievementForToday
        case SetAchievementGoal
        case ResultAchievementGoal
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func registerForNotifications(application: UIApplication) {
        let achievementWantedAction = UIMutableUserNotificationAction()
        achievementWantedAction.identifier = Notifications.Actions.SetAchievementGoal.rawValue
        achievementWantedAction.title = "Yes, Set my Goal!"
        achievementWantedAction.activationMode = .Foreground
        
        let achievementLeaveAction = UIMutableUserNotificationAction()
        achievementLeaveAction.identifier = Notifications.Actions.LeaveAchievementForToday.rawValue
        achievementLeaveAction.title = "Leave it for today..."
        achievementLeaveAction.activationMode = .Background

        let achievementResultAction = UIMutableUserNotificationAction()
        achievementResultAction.identifier = Notifications.Actions.ResultAchievementGoal.rawValue
        achievementResultAction.title = "Give my result reply"
        achievementResultAction.activationMode = .Foreground
        
        let categoryGoal = UIMutableUserNotificationCategory()
        categoryGoal.identifier = Notifications.Categories.MessageGoal.rawValue
        
        categoryGoal.setActions([achievementWantedAction, achievementLeaveAction], forContext: .Default)
        categoryGoal.setActions([achievementWantedAction, achievementLeaveAction], forContext: .Minimal)
        
        let categoryResult = UIMutableUserNotificationCategory()
        categoryResult.identifier = Notifications.Categories.MessageResult.rawValue
        
        categoryResult.setActions([achievementResultAction, achievementLeaveAction], forContext: .Default)
        categoryResult.setActions([achievementResultAction, achievementLeaveAction], forContext: .Minimal)
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: [categoryGoal, categoryResult])
        application.registerUserNotificationSettings(settings)
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        registerForNotifications(application)
       
        return true
    }

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        defer { completionHandler() }
        guard let identifier = identifier, let action = Notifications.Actions(rawValue: identifier) else { return }
        
        switch action {
            case .SetAchievementGoal:
                ViewController.goalState = .MessageGoal
            case .LeaveAchievementForToday:
                ViewController.goalState = .NoMessage
           case .ResultAchievementGoal:
                ViewController.goalState = .MessageResult
       }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

