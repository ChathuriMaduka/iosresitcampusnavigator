//
//  NotificationUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI


struct NotificationUIView: View {
    @State private var selectedTab = 0
    @State private var selectedBottomTab = 1
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showHome = false
    @State private var showLocation = false
    @State private var showFacility = false
    @State private var showProfile = false
    @State private var showNotification = false
    
    @State private var showNotificationDetail = false
    @State private var selectedNotification: NotificationItem?


    
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
                       if showNotificationDetail {
                                           Color.black.opacity(0.8)
                               .ignoresSafeArea(.all)
                                               .onTapGesture {
                                                   dismissPopup()
                                               }
                                               .zIndex(1)
                                           
                           NotificationPopupUIView(
                                               notification: selectedNotification,
                                               isPresented: $showNotificationDetail
                                           )
                                           .transition(.scale.combined(with: .opacity))
                                           .animation(.spring(response: 0.5, dampingFraction: 0.8), value: showNotificationDetail)
                                           .zIndex(2)
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
            
                                      .fullScreenCover(isPresented: $showHome) {
                                          HomeScreenView()
                                      }
                                      .fullScreenCover(isPresented: $showNotification) {
                                          NotificationUIView()
                                      }
                                      .fullScreenCover(isPresented: $showFacility) {
                                          FacilityUIView()
                                      }
                                      .fullScreenCover(isPresented: $showProfile) {
                                          ProfileDetailsView()
                                      }
                                      .fullScreenCover(isPresented: $showLocation) {
                                          CampusNavigationView()
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
                       
                       selectedNotification = notification
                              withAnimation(.easeInOut(duration: 0.3)) {
                                  showNotificationDetail = true
                              }
                       
                  }
    private func dismissPopup() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showNotificationDetail = false
        }
    }
    
           private func handleBottomTabSelection(_ index: Int) {
               

               
               
               print("Bottom tab selected: \(index)")
               
               switch index {
               case 0: // home
                   print("Navigate  on Home")
                   showHome = true
                   
               case 1: // notification
                   print("already notification")
                   showNotification = false
               case 2:
                   // Location
                   showLocation = true
                   print("Navigate to Location")
                   
               case 3: // facilities
                   print("Navigate to facility")
                   showFacility = true
                   
               case 4: // Profile
                   print("Navigate to Profile")
                   showProfile = true
               default:
                   break
               }

            }
    
}

#Preview {
    NotificationUIView()
}
