//
//  CampusNavigationView.swift
//  CampusNavigator
//
//  Created by Malsha Bopage on 2025-06-08.
//

import SwiftUI
import MapKit
import CoreLocation

struct CampusNavigationView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""
    @State private var showingWrongPathAlert = false
    @State private var isNavigating = false
    @State private var destinationName = "Hall No : 18"
    @State private var selectedDestination = 0
    @State private var userLocation = CLLocationCoordinate2D(latitude: 6.8649, longitude: 79.9734)
    @State private var currentPath: [CLLocationCoordinate2D] = []
    @State private var correctPath: [CLLocationCoordinate2D] = []
    @State private var isOnWrongPath = false
    @State private var pathTimer: Timer?
    @State private var movementStep = 0
    @State private var hasReachedDestination = false
    
   
    let campusLocations = [
        CampusLocation(name: "Hall No: 18", coordinate: CLLocationCoordinate2D(latitude: 6.8659, longitude: 79.9744), description: " Lecture Hall 18 , 2nd Floor"),
        CampusLocation(name: "Library", coordinate: CLLocationCoordinate2D(latitude: 6.8645, longitude: 79.9750), description: " Library , 3rd Floor"),
        CampusLocation(name: "iOS Lab", coordinate: CLLocationCoordinate2D(latitude: 6.8655, longitude: 79.9730), description: "iOS Lab, 3rd Floor"),
        CampusLocation(name: "Cafeteria", coordinate: CLLocationCoordinate2D(latitude: 6.8640, longitude: 79.9740), description: " Cafeteria, Ground Floor"),
        CampusLocation(name: "IT Lab", coordinate: CLLocationCoordinate2D(latitude: 6.8665, longitude: 79.9735), description: "IT Lab, 4th Floor"),
        CampusLocation(name: "Program Office", coordinate: CLLocationCoordinate2D(latitude: 6.8650, longitude: 79.9760), description: "Program Office, 4th Floor")
    ]
    
    var selectedLocation: CampusLocation {
        campusLocations[selectedDestination]
    }
    
    var body: some View {
        ZStack {
            // Map View
            MapView(
                userLocation: $userLocation,
                destination: .constant(selectedLocation.coordinate),
                currentPath: $currentPath,
                correctPath: $correctPath,
                isNavigating: $isNavigating,
                isOnWrongPath: $isOnWrongPath,
                campusLocations: campusLocations,
                selectedDestination: $selectedDestination
            )
            .ignoresSafeArea()
            
            VStack {
               
                VStack(spacing: 8) {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.appPrimaryBlue)
                            TextField("Select Destination...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color.appWhite)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        
                        Button(action: {
                            // Filter action
                        }) {
                        }
                    }
                    
                    // Destination Picker
                    if !isNavigating {
                        Picker("Destination", selection: $selectedDestination) {
                            ForEach(0..<campusLocations.count, id: \.self) { index in
                                Text(campusLocations[index].name).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Spacer()
                
               
                if isNavigating {
                    VStack {
                        if hasReachedDestination {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Destination Reached!")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("You have arrived at \(selectedLocation.name)")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button(action: {
                                    stopNavigation()
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.green)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                        } else if isOnWrongPath {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("You are going the wrong way.")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("Please return to the correct path")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button(action: {
                                    recalculateRoute()
                                }) {
                                    Image(systemName: "arrow.clockwise")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.red)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                        } else {
                            // Correct Path Navigation
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("You are on the right path")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                    Text("Reaching within 4 min")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button(action: {
                                    stopNavigation()
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.appPrimaryBlue)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                        }
                        
                        
                        HStack {
                            HStack {
                                Image(systemName: "building.2")
                                    .foregroundColor(.gray)
                                Text("NIBM Campus")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text(selectedLocation.name)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal, 16)
                }
                
               
                if !isNavigating {
                    VStack(spacing: 12) {
                        Button(action: {
                            startNavigation()
                        }) {
                            Text("Start Navigation to \(selectedLocation.name)")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 16)
                                .background(Color.appPrimaryBlue)
                                .cornerRadius(25)
                                .shadow(radius: 4)
                        }
                        
                        
                        Button(action: {
                            startWrongPathSimulation()
                        }) {
                            Text("Simulate Wrong Path")
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.appWarning, lineWidth: 1)
                                )
                                .cornerRadius(20)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            setupInitialRoute()
        }
        .onChange(of: selectedDestination) { _ in
            setupInitialRoute()
        }
    }
    
    private func setupInitialRoute() {
        let destination = selectedLocation.coordinate
        
       
        correctPath = createCorrectPath(to: destination)
        destinationName = selectedLocation.name
    }
    
    private func createCorrectPath(to destination: CLLocationCoordinate2D) -> [CLLocationCoordinate2D] {
        let startLat = userLocation.latitude
        let startLon = userLocation.longitude
        let endLat = destination.latitude
        let endLon = destination.longitude
        
       
        let numSteps = 8
        var path: [CLLocationCoordinate2D] = []
        
        for i in 0...numSteps {
            let progress = Double(i) / Double(numSteps)
            let lat = startLat + (endLat - startLat) * progress
            let lon = startLon + (endLon - startLon) * progress
            
            // Add some curve to make path more realistic
            let curve = sin(progress * .pi) * 0.0005
            path.append(CLLocationCoordinate2D(latitude: lat + curve, longitude: lon))
        }
        
        return path
    }
    
    private func startNavigation() {
        isNavigating = true
        currentPath = [userLocation]
        movementStep = 0
        hasReachedDestination = false
        isOnWrongPath = false
        
        
        pathTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            simulateCorrectMovement()
        }
    }
    
    private func startWrongPathSimulation() {
        isNavigating = true
        currentPath = [userLocation]
        movementStep = 0
        hasReachedDestination = false
        isOnWrongPath = false
        
        // Start wrong path simulation
        pathTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            simulateWrongMovement()
        }
    }
    
    private func simulateCorrectMovement() {
        guard movementStep < correctPath.count - 1 else {
            // Reached destination
            hasReachedDestination = true
            pathTimer?.invalidate()
            return
        }
        
        movementStep += 1
        let nextLocation = correctPath[movementStep]
        
        withAnimation(.easeInOut(duration: 1.0)) {
            userLocation = nextLocation
            currentPath.append(nextLocation)
        }
        
       
        let distanceToDestination = distance(from: userLocation, to: selectedLocation.coordinate)
        if distanceToDestination < 50 {
            hasReachedDestination = true
            pathTimer?.invalidate()
        }
    }
    
    private func simulateWrongMovement() {
       
        if movementStep < 4 {
            let wrongDirection = CLLocationCoordinate2D(
                latitude: userLocation.latitude + Double.random(in: -0.001...0.001),
                longitude: userLocation.longitude + Double.random(in: -0.001...0.001)
            )
            
            withAnimation(.easeInOut(duration: 1.0)) {
                userLocation = wrongDirection
                currentPath.append(wrongDirection)
            }
            
            movementStep += 1
            
           
            if let nearestCorrectPoint = findNearestPointOnCorrectPath() {
                let deviation = distance(from: userLocation, to: nearestCorrectPoint)
                if deviation > 100 {
                    withAnimation {
                        isOnWrongPath = true
                    }
                }
            }
        }
    }
    
    private func findNearestPointOnCorrectPath() -> CLLocationCoordinate2D? {
        guard !correctPath.isEmpty else { return nil }
        
        var nearestPoint = correctPath[0]
        var minDistance = distance(from: userLocation, to: correctPath[0])
        
        for point in correctPath {
            let dist = distance(from: userLocation, to: point)
            if dist < minDistance {
                minDistance = dist
                nearestPoint = point
            }
        }
        
        return nearestPoint
    }
    
    private func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return fromLocation.distance(from: toLocation)
    }
    
    private func recalculateRoute() {
        withAnimation {
            isOnWrongPath = false
        }
        
        
        setupInitialRoute()
        currentPath = [userLocation]
        movementStep = 0
        
       
        pathTimer?.invalidate()
        pathTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            simulateCorrectMovement()
        }
    }
    
    private func stopNavigation() {
        isNavigating = false
        hasReachedDestination = false
        isOnWrongPath = false
        currentPath = []
        pathTimer?.invalidate()
        pathTimer = nil
        movementStep = 0
    }
}

struct CampusLocation {
    let name: String
    let coordinate: CLLocationCoordinate2D
    let description: String
}

struct MapView: UIViewRepresentable {
    @Binding var userLocation: CLLocationCoordinate2D
    @Binding var destination: CLLocationCoordinate2D
    @Binding var currentPath: [CLLocationCoordinate2D]
    @Binding var correctPath: [CLLocationCoordinate2D]
    @Binding var isNavigating: Bool
    @Binding var isOnWrongPath: Bool
    let campusLocations: [CampusLocation]
    @Binding var selectedDestination: Int
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        mapView.userTrackingMode = .none
        
        // Set initial region (Sri Lankan university area)
        let region = MKCoordinateRegion(
            center: userLocation,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: false)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
       
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
       
        for (index, location) in campusLocations.enumerated() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.name
            annotation.subtitle = location.description
            mapView.addAnnotation(annotation)
        }
        
       
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation
        userAnnotation.title = "Your Location"
        mapView.addAnnotation(userAnnotation)
        
        if isNavigating {
            
            if correctPath.count > 1 {
                let correctPathPolyline = MKPolyline(coordinates: correctPath, count: correctPath.count)
                mapView.addOverlay(correctPathPolyline)
            }
            
           
            if currentPath.count > 1 {
                let currentPathPolyline = MKPolyline(coordinates: currentPath, count: currentPath.count)
                mapView.addOverlay(currentPathPolyline)
            }
        }
        
       
        if isNavigating {
            let region = MKCoordinateRegion(
                center: userLocation,
                latitudinalMeters: 2500,
                longitudinalMeters: 2500
            )
            mapView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                
               
                let isCurrentPath = overlay === mapView.overlays.last && parent.currentPath.count > 1
                
                if isCurrentPath && parent.isOnWrongPath {
                   
                    renderer.strokeColor = UIColor.red
                    renderer.lineWidth = 6
                    renderer.lineDashPattern = [10, 5]
                   
                } else if isCurrentPath {
                    
                    renderer.strokeColor = UIColor.systemBlue
                    renderer.lineWidth = 6
                } else {
                   
                    renderer.strokeColor = UIColor.systemBlue.withAlphaComponent(0.5)
                    renderer.lineWidth = 4
                    renderer.lineDashPattern = [5, 5]
                  
                }
                
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.title == "Your Location" {
                let identifier = "UserLocation"
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                
                if annotationView == nil {
                    annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView?.canShowCallout = true
                }
                
               
                annotationView?.image = UIImage(systemName: "location.circle.fill")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
                annotationView?.frame.size = CGSize(width: 30, height: 30)
                
                return annotationView
            } else {
                let identifier = "CampusLocation"
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                
                if annotationView == nil {
                    annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView?.canShowCallout = true
                } else {
                    annotationView?.annotation = annotation
                }
                
                
                if let pinView = annotationView as? MKPinAnnotationView {
                    let isSelected = annotation.title == parent.campusLocations[parent.selectedDestination].name
                    pinView.pinTintColor = isSelected ? .red : .orange
                }
                
                return annotationView
            }
        }
    }
}

struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .blue : .gray)
                .font(.system(size: 20))
        }
        .frame(maxWidth: .infinity)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAutherization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}

// Preview
struct CampusNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CampusNavigationView()
    }
}
