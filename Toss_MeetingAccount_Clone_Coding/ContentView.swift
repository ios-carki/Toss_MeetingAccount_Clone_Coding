//
//  ContentView.swift
//  Toss_MeetingAccount_Clone_Coding
//
//  Created by OWEN on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = Bool()
    @State private var offsetY: CGFloat = CGFloat()
    @State private var headerHeight: CGFloat = CGFloat()
    @State private var initOffsetY: CGFloat? = nil
    
    var body: some View {
        NavigationView(content: {
            GeometryReader { screenGeometry in
                
                ZStack {
                    Color.clear.ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0.0) {
                            
                            Color.black.opacity(0)                         // Test if we are in Center! >> change Color.clear to Color.blue and uncomment down code for Capsule() to see it!
                                .frame(height: UIScreen.main.bounds.height / 3)
                                .overlay( HeaderView(isPresented: $isPresented)
                                    .frame(height: UIScreen.main.bounds.height / 3)
                                    .background( GeometryReader { proxy in Color.clear.onAppear { headerHeight = proxy.size.height } } )
                                    .offset(y: headerHeight + screenGeometry.safeAreaInsets.top - offsetY))
                            
                            ZStack {
                                Color.backgroundColor.cornerRadius(20.0).shadow(color: .black.opacity(0.2), radius: 15, x: 0.0, y: 0.0)
                                    .padding(.bottom, -50).ignoresSafeArea()
                                
                                VStack {
                                    ForEach((0...30), id: \.self) { item in
                                        Text("item " + item.description)
                                            .foregroundColor(.white)
                                        Divider()
                                            .padding(.horizontal)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.top, 16)
                                .frame(minHeight: 700)
                            }
                            .overlay(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onChange(of: proxy.frame(in: .global).minY) { newValue in
                                            self.initOffsetY = newValue
                                            offsetY = newValue
                                        }
                                }
                            )
                            
                        }
                        
                    }
                    
                }
                .position(x: screenGeometry.size.width/2, y: screenGeometry.size.height/2)
                .alert(isPresented: $isPresented) { Alert(title: Text("Button tapped")) }
                .statusBar(hidden: true)
                
            }
        })
        .shadow(radius: 10.0)
        .onAppear {
            self.offsetY = self.initOffsetY ?? 0.0
        }
        .navigationTitle("ddasd")
        
    }
}
struct HeaderView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20.0) {
            
            button(color: Color(UIColor.systemTeal))
            
            Text("Some text 1").bold()
            
            Text("Some text 2").bold()
            
            button(color: Color(UIColor.green))
            
            Text("Some text 3").bold()
            
            Text("Some text 4").bold()
            
            button(color: Color.purple)
            
        }
    }
    
    func button(color: Color) -> some View {
        
        return Button(action: { isPresented.toggle() }, label: {
            
            Text("Start")
                .bold()
                .padding()
                .shadow(radius: 10.0)
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(16)
            
        })
        
    }
    
}
#Preview {
    ContentView()
}
