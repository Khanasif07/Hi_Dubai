//
//  Goal.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 03/07/2023.
//

import Foundation

struct Goal {
    let title: String
    let Actions: [Action]
}

struct Action {
    let title: String
}


let sample = [
    Goal(title: "Learn iOS",
         Actions: [
            Action(title: "Learn Swift"),
            Action(title: "Go Throught WWDC Videos")
         ]),
    Goal(title: "Learn Node.JS",
         Actions: [
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node")
         ]),
    Goal(title: "Learn Node.JS",
         Actions: [
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript")
         ]),
    Goal(title: "Learn Node.JS",
                 Actions: [
                    Action(title: "Learn JavaScript"),
                    Action(title: "Learn Node")
                 ]),
    Goal(title: "Learn Node.JS",
         Actions: [
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node")
         ]),
    Goal(title: "Learn Node.JS",
         Actions: [
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node")
         ]),
    Goal(title: "Learn Node.JS",
         Actions: [
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node"),
            Action(title: "Learn JavaScript"),
            Action(title: "Learn Node")
         ])
]
