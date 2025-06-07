//
//  NotificationUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI


struct NotificationUIView: View {
    @State private var selectedTab = 0
    @State private var selectedBottomTab = 0
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showHome = false
    @State private var showLocation = false
    @State private var showFacilityDetail = false
    @State private var showProfile = false


    
    //notification data enum
    let notifications = [
        NotificationItem(
            title: "Cafeteria Crowded",
            message: "Expected delays of 30 mins",
            updatedTime: "5mins ago",
            type: .alert
        ),
        NotificationItem(
            title: "Auditorium Repairing",
            message: "Expected delays of 1 day.",
            updatedTime: "1mins ago",
            type: .alert
        ),
        NotificationItem(
            title: "Research Session",
            message: "Mandatory Session will con...",
            updatedTime: "1mins ago",
            type: .warning
        ),
        NotificationItem(
            title: "System Maintenance",
            message: "Scheduled maintenance at 2 AM",
            updatedTime: "10mins ago",
            type: .info
        ),
        NotificationItem(
            title: "Task Completed",
            message: "Your assignment was submitted",
            updatedTime: "1 day ago",
            type: .success
        ),
        NotificationItem(
            title: "Library Hours Extended",
            message: "Open until 11 PM this week",
            updatedTime: "1 day ago",
            type: .info
        ),
        NotificationItem(
            title: "Assignment Reminder",
            message: "Physics homework due tomorrow",
            updatedTime: "1 day ago",
            type: .warning
        ),
        NotificationItem(
            title: "System Maintenance Completed",
            message: "completed maintenance at 2 AM",
            updatedTime: "2 days  ago",
            type: .success
        ),
        NotificationItem(
            title: "System Maintenance Completed",
            message: "completed maintenance at 2 AM",
            updatedTime: "2 days  ago",
            type: .warning
        ),
        NotificationItem(
            title: "Library Crowded",
            message: "Expected delays of 30 mins",
            updatedTime: "3 day ago",
            type: .alert
        ),
    ]
         

    var body: some View {
        NavigationView{
                   VStack(spacing: 0) {
                       HStack(spacing: 12) {
                           ForEach(Array(["Today", "Yesterday", "Earlier"].enumerated()), id: \.offset) { index, title in
                               Button(action: {
                                   selectedTab = index
                               }) {
                                   Text(title)
                                       .font(.system(size: 16, weight: .medium))
                                       .foregroundColor(selectedTab == index ? .appWhite : .appPrimaryBlue)
                                       .padding(.horizontal, 24)
                                       .padding(.vertical, 10)
                                       .background(
                                           selectedTab == index ? Color.appPrimaryBlue : Color.clear
                                       )
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(Color.appPrimaryBlue, lineWidth: 1)
                                       )
                                       .cornerRadius(20)
                                   
                               }
                           }
                           Spacer()
                       }
                       .padding(.horizontal, 16)
                       .padding(.top, 16)
                       
                       ScrollView {
                           LazyVStack(spacing: 20) {
                               ForEach(getFilteredNotifications(), id: \.id) { notification in
                                   _NotificatonCardUIView(notification: notification) {
                                       handleViewMoreTapped(for: notification)
                                   }
                               }
                           }
                           .padding(.horizontal, 16)
                           .padding(.top, 30)
                           
                       }
                       BotemNavigationBarUIView(selectedTab: $selectedBottomTab) { index in
                           handleBottomTabSelection(index)
                       }
                       
                       Spacer()

                   }
            
                   .navigationTitle("Notifications")
                                      .navigationBarTitleDisplayMode(.inline)
                                      .navigationBarBackButtonHidden(true)
                                      .toolbar {
                                          ToolbarItem(placement: .navigationBarLeading) {
                                              Button(action: {
                                                  // add Navigate back to home screen
                                                  presentationMode.wrappedValue.dismiss()
                                              }) {
                                                  HStack(spacing: 4) {
                                                      Image(systemName: "arrow.left")
                                                          .foregroundColor(.appPrimaryBlue)
                                                          .font(.appBodySemibold)
                                                                                                        }
                                              }
                                          }
                                      }
                                      .toolbarColorScheme(.light)
                                      .toolbarBackground(Color.clear, for: .navigationBar)

                                      .onAppear {
                                          let appearance = UINavigationBarAppearance()
                                          appearance.configureWithTransparentBackground()
                                          appearance.titleTextAttributes = [
                                            .foregroundColor: UIColor.red,
                                              .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                          ]
                                          
                                          UINavigationBar.appearance().standardAppearance = appearance
                                          UINavigationBar.appearance().scrollEdgeAppearance = appearance
                   }


                                                  .sheet(isPresented: $showFacilityDetail) {
                                                      FacilityDetailView()
                                                  }

               }
        
           }
              
                   
                   private func getFilteredNotifications() -> [NotificationItem] {
                       switch selectedTab {
                       case 0: // Today
                           return Array(notifications.prefix(4))
                       case 1: // Yesterday
                           return Array(notifications.dropFirst(4).prefix(3))
                       case 2: // Earlier
                           return Array(notifications.dropFirst(6))
                       default:
                           return notifications
                       }
                   }
                   
                   private func handleViewMoreTapped(for notification: NotificationItem) {
                       print("View more tapped for: \(notification.title)")
                       
                       switch notification.type {
                      case .alert:
                           print("Handling alert notification action")
                       case .warning:
                           print("Handling warning notification action")
                       case .info:
                           print("Handling info notification action")
                       case .success:
                           print("Handling success notification action")
                       }
                       
           }
           private func handleBottomTabSelection(_ index: Int) {
               

               
               
               print("Bottom tab selected: \(index)")
               
               switch index {
               case 0: // Notifications
                   print("Already on Notifications")
                   
               case 1: // Home
                   print("Navigate to Home")
               case 2: // Location
                   print("Navigate to Location")
                   
               case 3: // facilities
                   print("Navigate to facility")
                   showFacilityDetail = true
                   
               case 4: // Profile
                   
                   print("Navigate to Profile")
               default:
                   break
               }

            }
    
}

#Preview {
    NotificationUIView()
}
