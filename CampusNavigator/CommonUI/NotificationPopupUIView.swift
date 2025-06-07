//
//  NotificationPopupUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI

struct NotificationPopupUIView: View {
    let notification: NotificationItem?
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Semi-transparent background overlay
            Color.appBlack.opacity(0.8)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
            
            if let notification = notification {
                VStack(spacing: 20) {
                    
                    VStack(spacing: 16) {
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 8) {
                                    getNotificationIcon(for: notification.type)
                                        .foregroundColor(getNotificationColor(for: notification.type))
                                        .font(.appBodySemibold)
                                    
                                    Text(getNotificationTypeText(for: notification.type))
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(getNotificationColor(for: notification.type))
                                        .textCase(.uppercase)
                                }
                                
                                Text(notification.title)
                                    .font(.appTitle1Bold)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
                        }
                        
                        Divider()
                            .background(Color.appDarkGray.opacity(0.3))
                        
                        // Full message content
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(getFullMessage(for: notification))
                                    .font(.appBodyRegular)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            
                            HStack {
                                Text("Updated: \(notification.updatedTime)")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            // OK Button
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isPresented = false
                                }
                            }) {
                                Text("OK")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.appPrimaryBlue)
                                    .cornerRadius(12)
                            }
                            Spacer()
                        }
                    }
                    .padding(24)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 8)
                    
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: 350)
                .background(Color.clear)
            }
            
        }
    }
}

extension NotificationPopupUIView {
    
    private func getNotificationIcon(for type: NotificationType) -> Image {
        switch type {
        case .alert:
            return Image(systemName: "exclamationmark.triangle.fill")
        case .warning:
            return Image(systemName: "exclamationmark.circle.fill")
        case .info:
            return Image(systemName: "info.circle.fill")
        case .success:
            return Image(systemName: "checkmark.circle.fill")
        }
    }
    
    private func getNotificationColor(for type: NotificationType) -> Color {
        switch type {
        case .alert:
            return .red
        case .warning:
            return .orange
        case .info:
            return .blue
        case .success:
            return .green
        }
    }
    

    private func getNotificationTypeText(for type: NotificationType) -> String {
        switch type {
        case .alert:
            return "Alert"
        case .warning:
            return "Warning"
        case .info:
            return "Info"
        case .success:
            return "Success"
        }
    }
    

    private func getFullMessage(for notification: NotificationItem) -> String {
        switch notification.title {
        case "Cafeteria Crowded":
            return "The main cafeteria is experiencing high traffic during lunch hours. Expected delays of approximately 30 minutes for food service. Consider visiting the secondary dining area or planning your meal for off-peak hours."
            
        case "Auditorium Repairing":
            return "The main auditorium is currently undergoing essential maintenance and repairs. All scheduled events have been moved to alternative venues. Expected completion time is 1 day. Please check your event notifications for updated locations."
            
        case "Research Session":
            return "Mandatory Research Session will commence tomorrow at 2:00 PM in the research laboratory. All graduate students are required to attend. The session will cover new research methodologies and project guidelines for the upcoming semester."
            
        case "System Maintenance":
            return "Scheduled system maintenance will occur tonight at 2:00 AM. During this time, the campus navigation system and online services may be temporarily unavailable. Maintenance is expected to last 2-3 hours."
            
        case "Task Completed":
            return "Your assignment has been successfully submitted to the course portal. The submission was received on time and is now available for instructor review. You will receive feedback within 5-7 business days."
            
        case "Library Hours Extended":
            return "Due to upcoming final examinations, the campus library will extend its operating hours. The library will remain open until 11:00 PM throughout this week to accommodate increased study demands."
            
        case "Assignment Reminder":
            return "This is a reminder that your Physics homework assignment is due tomorrow by 11:59 PM. Please ensure all calculations are shown clearly and submit through the online portal before the deadline."
            
        case "System Maintenance Completed":
            return "The scheduled system maintenance has been completed successfully at 2:00 AM. All campus systems are now fully operational. Thank you for your patience during the maintenance period."
            
        case "Library Crowded":
            return "The main library is currently at full capacity. Expected wait time for available study spaces is approximately 30 minutes. Alternative study areas are available in the student center and departmental libraries."
            
        default:
            return notification.message
        }
    }
}


