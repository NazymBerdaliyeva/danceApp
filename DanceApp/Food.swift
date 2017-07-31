//
//  Food.swift
//  DanceApp
//
//  Created by mac on 28.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
enum Kuhnya: String{
    case Kazakh = "Kazakh"
    case Russian = "Russian"
    case Japanese = "Japanese"
}

class Food {
    var kuhnya: Kuhnya?
    var name: String?
    var detail: String?
    var image: UIImage
    
    init(kuhnya: Kuhnya, name: String, detail: String, image: UIImage) {
        self.kuhnya = kuhnya
        self.name = name
        self.detail = detail
        self.image = image
    }
    
    static func loadData() -> [[Food]]{
        return [[Food(kuhnya: .Kazakh, name: "Beshbarmak", detail: "The term Beshbarmak means \"five fingers\", because nomads used to eat this dish with their hands. The boiled meat is finely chopped with knives, mixed with boiled noodles, and spiced with onion sauce. It is usually served in a big round dish.", image: #imageLiteral(resourceName: "beshbarmak")),
                 Food(kuhnya: .Kazakh, name: "Kuyrdak", detail: "A dish made from roasted horse, sheep, or cow offal, with the heart, liver, kidneys, and other organs, diced and served with onions and peppers", image: #imageLiteral(resourceName: "kuyrdak") ),
                 Food(kuhnya: .Kazakh, name: "Baursak", detail: "Baursaks is a simple product made with flour, eggs, sugar and butter. It is fried and, once it has cooled, eaten like a cookie, either with tea, at breakfast, with honey or jam.", image: #imageLiteral(resourceName: "baursak")),
                 Food(kuhnya: .Kazakh, name: "Kurt", detail: "Kurt represents a traditional dish in the Kazakh cuisine that is prepared from dried cheese and whey. The thick sour cream is pressed and is dried until white and salty. The dish may take various shapes, these including balls, strips or even arranged into chunks. The size of it also tends to vary.", image: #imageLiteral(resourceName: "kurt")),
                 ],
                [Food(kuhnya: .Russian, name: "Pelmeni", detail: "Dough: flour, water, sometimes eggs. Filling: minced meat (pork, lamb, beef, or any other kind of meat), fish, or mushrooms. ... Pelmeni are dumplings consisting of a filling wrapped in thin, unleavened dough.", image: #imageLiteral(resourceName: "pelmeni")),
                 Food(kuhnya: .Russian, name: "Borsh", detail: "Borscht is one of those soups that has dozens of variations. This version of the classic Russian beet soup uses lots of vegetables and a touch of bacon for extra flavor.", image: #imageLiteral(resourceName: "borch")),
                 Food(kuhnya: .Russian, name: "Kulich", detail: "Traditionally after the Easter service, the kulich, which has been put into a basket and decorated with colorful flowers, is blessed by the priest. Blessed kulich is eaten before breakfast each day. ", image: #imageLiteral(resourceName: "kulich")),
                 Food(kuhnya: .Russian, name: "Blini", detail: "A light pancake served with melted butter, sour cream, and other garnishes such as caviar.", image: #imageLiteral(resourceName: "blini")),
                 ],
                [Food(kuhnya: .Japanese, name: "Ramen", detail: "Ramen is a pale, clear, yellowish broth made with plenty of salt and any combination of chicken, vegetables, fish, and seaweed. Occasionally pork bones are also used, but they are not boiled as long as they are for tonkotsu ramen, so the soup remains light and clear.", image: #imageLiteral(resourceName: "ramen")),
                 Food(kuhnya: .Japanese, name: "Sushi", detail: "Sushi can be prepared with either brown or white rice. It is often prepared with raw seafood, but some common varieties of sushi use cooked ingredients, and many other sorts are vegetarian. Sushi is often served with pickled ginger, wasabi, and soy sauce.", image: #imageLiteral(resourceName: "sushi")),
                 Food(kuhnya: .Japanese, name: "Egg Rolls", detail: "Egg rolls are usually stuffed with pork, shrimp, or chicken, adding cabbage, carrots, bean sprouts and other vegetables, and then deep fried.", image: #imageLiteral(resourceName: "egg-rolls")),
                 Food(kuhnya: .Japanese, name: "Miso", detail: "Cream stew - Yōshoku dish consisting of meat and mixed vegetables cooked in thick white roux. Dashi – a class of soup and cooking stock used in Japanese cuisine. Hōtō - Regional dish made by stewing flat udon noodles and vegetables in miso soup.", image:#imageLiteral(resourceName: "miso")) ]]
    }
    
}
