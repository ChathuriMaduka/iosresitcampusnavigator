//
//   NotificatonCardUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI

struct NotificationItem {
    let id = UUID()
    let title: String
    let message: String
    let updatedTime: String
    let type: NotificationType
}

enum NotificationType {
    case warning
    case alert
    case info
    case success
    
    var backgroundColor: Color {
        switch self {
        case .warning:
            return Color.appLightYellow.opacity(0.1)
        case .alert:
            return Color.appLightRed.opacity(0.1)
        case .info:
            return Color.appLightBlue.opacity(0.1)
        case .success:
            return Color.appSuccess.opacity(0.1)
        }
    }
    
    var borderColor: Color {
           switch self {
           case .warning:
               return Color.appDarkYellow.opacity(0.3)
           case .alert:
               return Color.appRed.opacity(0.3)
           case .info:
               return Color.appPrimaryBlue.opacity(0.3)
           case .success:
               return Color.appSuccess.opacity(0.3)
           }
       }
    
    var iconColor: Color {
            switch self {
            case .warning:
                return Color.appDarkYellow
            case .alert:
                return Color.appRed
            case .info:
                return Color.appPrimaryBlue
            case .success:
                return Color.appSuccess
            }
        }
        
    
    var buttonColor: Color {
        switch self {
        case .warning:
            return Color.appDarkYellow
        case .alert:
            return Color.appRed
        case .info:
            return Color.appPrimaryBlue
        case .success:
            return Color.appSuccess
        }
    }
    
    var titleColor: Color {
        switch self {
        case .warning:
            return Color.appDarkYellow
        case .alert:
            return Color.appRed
        case .info:
            return Color.appPrimaryBlue
        case .success:
            return Color.appSuccess
        }
    }
}
    
    struct _NotificatonCardUIView: View {
        
        let notification: NotificationItem
        let onViewMore: () -> Void
        

        var body: some View {
            HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(notification.title)
                                .font(.appBodySemibold)
                                .foregroundColor(notification.type.titleColor)
                            
                            Text(notification.message)
                                .font(.appFootnoteRegular)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            
                            Text("Updated \(notification.updatedTime)")
                                .font(.appCaptionRegular)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            
                           
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(notification.type.iconColor)
                            
                          
                            Button(action: onViewMore) {
                                Text("View More")
                                    .font(.appFootnoteSemibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(notification.type.buttonColor)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(16)
                    .background(notification.type.backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(notification.type.borderColor, lineWidth: 1)
                    )
                    .cornerRadius(12)
        }
    }
    
   
