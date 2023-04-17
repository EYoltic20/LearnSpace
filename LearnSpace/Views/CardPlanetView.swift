//
//  CardPlanetView.swift
//  LearnSpace
//
//  Created by Emilio Y Martinez on 15/04/23.
//

import SwiftUI

struct CardPlanetView: View {
    var color: UIColor
    var Planeta:String
    var image : String
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(color))
            
                .overlay{
                    VStack(){
                        Image(image)
                            .resizable()
                            .frame(width:100,height:100)
                            .scaledToFit()
                   
        
                        Text(Planeta)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.trailing,230)
                        
                    }
                    
                }
                .padding()
            
            
        }
        
        
    }
}

struct CardPlanetView_Previews: PreviewProvider {
    static var previews: some View {
        CardPlanetView(color: .red, Planeta: "tierra",image: "planeta-tierra")
    }
}
