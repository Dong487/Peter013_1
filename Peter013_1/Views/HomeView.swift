//
//  HomeView.swift
//  Peter013_1
//
//  Created by DONG SHENG on 2022/7/6.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            
            Image("Background1")
                .resizable()
                .ignoresSafeArea()
         
            VStack(spacing: 0){
                ImageView
      
                PickerView

                SliderView

                Spacer()
            }
            .ignoresSafeArea()
        }
        .onAppear{
            // timer 會自動連接所以設定成false斷開 (.autoconnect())
            viewModel.timerStart = false
        }
        .onReceive(viewModel.timer) { _ in
            withAnimation(.easeInOut){
                viewModel.random()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView{
    
    private var ImageView: some View{
        ZStack{

            VStack(spacing: 0){
                
                Rectangle() // 空
                    .opacity(0)
                    .frame(height: 150)
                
                // 衣服
                Rectangle()
                    .fill(Color(red: viewModel.clothesColor.red, green: viewModel.clothesColor.green, blue: viewModel.clothesColor.blue))
                    .opacity(viewModel.clothesColor.opacity)
                    .frame(height: 160)
                
                // 褲子
                Rectangle()
                    .fill(Color(red: viewModel.pantsColor.red, green: viewModel.pantsColor.green, blue: viewModel.pantsColor.blue))
                    .opacity(viewModel.pantsColor.opacity)
                    .frame(height: 60)

                Rectangle()
                    .fill(Color(red: viewModel.shoesColor.red, green: viewModel.shoesColor.green, blue: viewModel.shoesColor.blue))
                    .opacity(viewModel.shoesColor.opacity)
                    .frame(height: 75)
                
                Spacer()
            }
            .frame(width: 245, height: 500)
            .offset(x: -25)
            
            Image("Image1")
                .resizable()
                .scaledToFit()
                .cornerRadius(viewModel.cornerRadius)
                .frame(width: 380, height: 500)
                
        }
        .shadow(color: .white.opacity(0.7), radius: 2, x: -1.5, y: -1.5)
        .shadow(color: .white, radius: 2, x: -1, y: -1)
        .shadow(color: .black, radius: 2, x: 2, y: 1)
        .frame(width: UIScreen.main.bounds.width * 0.6, height: 300)
        .scaleEffect(0.6)
        .padding(.top ,100)
        .overlay(ButtonView ,alignment: .bottomTrailing)
    }
    
    // 選擇 衣服、褲子、鞋子
    private var PickerView: some View{
        VStack{
            Picker(selection: $viewModel.selection){
                    ForEach(viewModel.name.indices) { index in
                    Text(viewModel.name[index])
                        .tag(viewModel.name[index])
                        
                }
            } label: {
                // 可以省略
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var SliderView: some View{
        VStack {
            Slider(value: viewModel.redSlider(),
                   in: 0...1,
                   minimumValueLabel:
                    Text("紅色")
                        .font(.headline)
                   ,
                   maximumValueLabel: Text(viewModel.redText()),
                   label:{ Text("RED") }
            )
            .shadow(color: .red.opacity(0.8), radius: 2, x: 1, y: 1)
            .accentColor(.red)
            
            
            Slider(value: viewModel.greenSlider(),
                   in: 0...1,
                   minimumValueLabel:
                    Text("綠色")
                        .font(.headline)
                   ,
                   maximumValueLabel: Text(viewModel.greenText()),
                   label:{ Text("GREEN") }
            )
            .shadow(color: .green.opacity(0.8), radius: 2, x: 1, y: 1)
            .accentColor(.green)
            
            Slider(value: viewModel.blueSlider(),
                   in: 0...1,
                   minimumValueLabel:
                    Text("藍色")
                        .font(.headline)
                   ,
                   maximumValueLabel: Text(viewModel.blueText()),
                   label:{ Text("BLUE") }
            )
            .shadow(color: .blue.opacity(0.8), radius: 2, x: 1, y: 1)
            .accentColor(.blue)
            
            Slider(value: viewModel.opacitySlider(),
                   in: 0...100,
                   minimumValueLabel:
                    Text("透明")
                        .font(.headline)
                   ,
                   maximumValueLabel: Text(viewModel.opacityText()),
                   label:{ Text("GREEN") }
            )
            
            HStack{
                Slider(value: $viewModel.cornerRadius,
                       in: 0...70,
                       minimumValueLabel:
                        Text("圓角")
                            .font(.headline)
                       ,
                       maximumValueLabel: Text("\(viewModel.cornerRadius ,specifier: "%.1f")"),
                       label:{ Text("GREEN") }
                )
                    .disabled(!viewModel.lock)
                    .shadow(color: .brown.opacity(0.8), radius: 2, x: 1, y: 1)
                    .accentColor(.brown)
                
                Toggle(isOn: $viewModel.lock) {
                    
                }
                .toggleStyle(SwitchToggleStyle(tint: .brown))
            }
        }
        .accentColor(.white)
        .foregroundColor(.white)
        .padding()
        .background(.black.opacity(0.1))
        .shadow(color: .black.opacity(0.3), radius: 0.7, x: 0.7, y: 1)
        .cornerRadius(8)
        .padding(.horizontal ,8)
        
    }
    
    // 隨機
    private var ButtonView: some View{
        VStack(spacing: 30){
            
            Button {
                viewModel.reset()
            } label: {
                Image(systemName: "arrow.uturn.backward.circle")
                    .resizable()
                    .foregroundColor(.white)
                    
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(.brown)
                            .frame(width: 50, height: 50)
                    )
            }
            
            Button {
                viewModel.random()
            } label: {
                Image(systemName: "dice")
                    .resizable()
                    .foregroundColor(.white)
                    
                    .frame(width: 30, height: 30)
                    .background(
                        ZStack{
                            Circle()
                                .fill(.black)
                                .frame(width: 50, height: 50)
                            
                            Circle()
                                .fill(.red.opacity(0.85))
                                .frame(width: 45, height: 45)
                        }
                    )
            }
            
            Button {
                self.viewModel.timerStart.toggle()
            } label: {
                Image(systemName: viewModel.timerStart ? "pause.circle" : "clock.arrow.2.circlepath")
                    .resizable()
                    .foregroundColor(.white)
                    
                    .frame(width: 30, height: 30)
                    .background(
                        ZStack{
                            Circle()
                                .fill(.black)
                                .frame(width: 50, height: 50)
                            
                            Circle()
                                .fill(.red.opacity(0.85))
                                .frame(width: 45, height: 45)
                            
                        }
                    )
            }
        }
        .offset(x: 20)
    }
}
