//
//  Notification.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 30/10/2023.
//

import Foundation

struct Notification {
    let isRead: Bool
}

extension Array where Element == Notification {
    /**
     Checks if the array of Notifications contains at least one unread notification.

     - Returns: `true` if there is an unread notification in the array, `false` otherwise.
     */
    func hasUnreadNotification() -> Bool {
        // Use the `contains` method with a closure to check if there is an unread notification.
        return contains { !$0.isRead }
    }
}
