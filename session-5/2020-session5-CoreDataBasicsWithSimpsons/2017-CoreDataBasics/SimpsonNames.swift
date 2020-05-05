//
//  SimpsonNames.swift
//  2017-CoreDataBasics
//
//  Created by T. Andrew Binkowski on 4/29/18.
//  Copyright © 2018 T. Andrew Binkowski. All rights reserved.
//

import Foundation

struct SimpsonNames {

let simpsonNames =
  [
    "Homer J. Simpson",
    "Marge Simpson (née Bouvier)",
    "Bart Simpson",
    "Lisa Simpson",
    "Maggie Simpson",
    "Grandpa Abe Simpson",
    "Patty Bouvier",
    "Selma Bouvier",
    "Mona Simpson",
    "Santa's Little Helper",
    "Snowballs (I-V)",
    "Coltrane",
    "Ling Bouvier",
    "Amos Simpson",
    "Jacqueline Bouvier",
    "Montgomery Burns",
    "Waylon Smithers",
    "Moe Szyslak",
    "Barney Gumble",
    "Kent Brockman",
    "Mayor Quimby",
    "Lenny Leonard",
    "Carl Carlson",
    "Krusty The Clown",
    "Doctor Hibbert",
    "Ned Flanders",
    "Rod Flanders",
    "Todd Flanders",
    "Maude",
    "Kang",
    "Kodos",
    "Milhouse Van Houten",
    "Sherri and Terri",
    "Nelson Muntz",
    "Comic Book Guy",
    "Apu Nahasapeemapetilon",
    "Martin Prince",
    "Seymour Skinner",
    "Chief Wiggum",
    "Ralph Wiggum",
    "Jasper",
    "Captain McAllister,",
    "Otto Mann",
    "Bumblebee Man",
    "Itchy and Scratchy",
    "Jimbo Jones",
    "Snake (Jailbird)",
    "Old Gil Gunderson",
    "Sideshow Bob (Robert Terwilliger)",
    "Fat Tony",
    "Sideshow Cecil (Cecil Terwilliger)",
    "Janey",
    "Ranier Wolfcastle",
    "Mr Largo",
    "Bruno",
    "Superintendent Chalmers",
    "Agnes Skinner",
    "Mrs. Krabappel and Ms. Hoover",
    "Groundskeeper Willie",
    "Cletus",
    "Hans Moleman",
    "Sideshow Mel",
    "Dolph Starbeam",
    "Professor Frink",
    "Kearney Zzyzwick",
    "Yes Guy",
    "Squeaky Voice Teen",
    "Wendell Borton",
    "Troy McClure",
    "Lionel Hutz",
    "Judge Snyder",
    "Lou and Eddie",
    "Legs and Louie",
    "Reverend Lovejoy",
    "Helen Lovejoy",
    "Uter",
    "Database",
    "Manjula",
    "Kirk",
    "Luann",
    "Old Jewish man",
    "Allison Taylor",
    "Arnie Pye",
    "Blue Haired Lawyer",
    "Richard",
    "Lewis",
    "Marvin Monroe",
    "Rich Texan",
    "Drederick Tatum",
    "Wiseguy",
    "Sanjay",
    "Sam and Larry",
    "Bernice",
    "Mrs. Glick",
    "Disco Stu",
    "Hyman Krustofski",
    "Lindsey Naegle",
    "Martin Prince Sr.",
    "Martha Prince",
    "Brandine Spuckler",
    "Luigi",
    "Radioactive man",
    "Duffman",
    "Doris Freedman",
    "Cookie Kwan",
    "Benjamin",
    "Akira",
    "Artie Ziff",
    "Arthur Crandall",
    "Gabbo",
    "Gerald",
    "Bill",
    "Marty",
    "Billy",
    "Birch Barlow",
    "Bleeding Gums Murphy",
    "Blinky",
    "Booberella",
    "Brunella Pommelhorst",
    "Capitol City Goofball",
    "Lance Murdock",
    "Charlie",
    "Kumiko",
    "Pyro",
    "Lugash",
    "Corporal Punishment",
    "Crazy Cat Lady",
    "Crusher",
    "Lowblow",
    "Dave Shutton",
    "Declan Desmond",
    "Doctor Colossus",
    "Fallout boy",
    "Francesca Terwilliger",
    "Frankie The Squealer",
    "Gino",
    "Gloria",
    "God",
    "Grady",
    "Julio",
    "Greta",
    "Gunter",
    "Ernst",
    "Anastasia",
    "Happy Little Elves",
    "Jack Marley",
    "Jay Sherman",
    "Jebidiah Springfield",
    "Johnny Tightlips",
    "Joey",
    "Jub - Jub",
    "Constance Harm",
    "Just Stamp the Ticket man",
    "J. Loren Pryor",
    "Kearney Zzyzwicz Jr.",
    "Leopold",
    "Lois Pennycandy",
    "Lucius Sweet",
    "Lurleen Lumpkin",
    "Martha Prince",
    "Mary Bailey",
    "Mary Spuckler",
    "Mayor Quimby's Body Guards",
    "Ms. Albright",
    "Miss Springfield",
    "Mr. Costington",
    "Mr. Teeny",
    "Mrs. Muntz",
    "Octuplets",
    "Jake",
    "Opal",
    "Patches",
    "Poor Violet",
    "Plopper",
    "Poochie",
    "Princess Kashmir",
    "Principal Dondelinger",
    "Rachel Jordan",
    "Roger Meyers Jr.",
    "Ruth Powers",
    "Sarah Wiggum",
    "Scott Christian",
    "Shauna",
    "Stampy",
    "State Comptroller Atkins",
    "Tina Ballerina",
    "The Warden",
    "Vanderbilts",
    "Weasels",
    "Mr. Winfield",
    "Sylvia Winfield",
    "Hank Scorpio",
    "Frank Grimes",
    "Frank Grimes Jr.",
    "Shary Bobbins"
]


  func randomName() -> String {
    func random(_ n:Int) -> Int {
      return Int(arc4random_uniform(UInt32(n)))
    }
    return simpsonNames[random(simpsonNames.count)]
  }
}

