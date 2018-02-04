//
//  EpisodeTest.swift
//  Func&closure
//
//  Created by luoxiaofeng on 2018/02/03.
//  Copyright © 2018年 luoxiaofeng. All rights reserved.
//

import UIKit

var str = "Hello, playground"

final class Episode: NSObject {

    @objc var title: String
    @objc var type: String
    @objc var length: Int

    init(title: String, type: String, length: Int) {
        self.title = title
        self.type = type
        self.length = length
    }

    override var description: String {

        return title + "\t" + type + "\t" + String(length)
    }

}

let episodes = [Episode.init(title: "title 1", type: "Free", length: 520),
                Episode.init(title: "title 4", type: "Paid", length: 500),
                Episode.init(title: "title 2", type: "Free", length: 330),
                Episode.init(title: "title 5", type: "Paid", length: 260),
                Episode.init(title: "title 3", type: "Free", length: 240),
                Episode.init(title: "title 6", type: "Paid", length: 390)]

// NSSortDescriptor
let typeDescriptor = NSSortDescriptor(key: #keyPath(Episode.type),
                                      ascending: true,
                                      selector: #selector(NSString.localizedCompare(_:)))

let lengthDescriptor = NSSortDescriptor(key: #keyPath(Episode.length),
                                        ascending: true)

let descroptors = [typeDescriptor, lengthDescriptor]

let sortedEpisodes = (episodes as NSArray).sortedArray(using: descroptors)

sortedEpisodes.forEach { print($0 as! Episode) }


//---------<swift descripor>
// 纯swift，不参杂OC
struct Episodes: CustomStringConvertible {

    var title: String
    var type: String
    var length: Int

    init(title: String, type: String, length: Int) {
        self.title = title
        self.type = type
        self.length = length
    }

    var description: String {

        return title + "\t" + type + "\t" + String(length)
    }

}

let episode = [Episodes.init(title: "title 1", type: "Free", length: 520),
               Episodes.init(title: "title 4", type: "Paid", length: 500),
               Episodes.init(title: "title 2", type: "Free", length: 330),
               Episodes.init(title: "title 5", type: "Paid", length: 260),
               Episodes.init(title: "title 3", type: "Free", length: 240),
               Episodes.init(title: "title 6", type: "Paid", length: 390)]

typealias SortDescriptor<T> = (T, T) -> Bool

func makeDescriptor<Key, Value>(key: @escaping(Key) -> Value,
                                _ isAscending: @escaping (Value, Value) -> Bool) -> SortDescriptor<Key> {

    return { isAscending(key($0), key($1)) }
}

func shift<T>(_ compare: @escaping SortDescriptor<T>) -> SortDescriptor<T?> {

    return { l, r in

        switch (l, r) {
        case (nil, nil):
            return false
        case (nil, _):
            return false
        case (_, nil):
            return true
        case let(l?, r?):
            return compare(l, r)
        default:
            fatalError()
        }

    }
}

let typeDescriptor2: SortDescriptor<Episodes> = makeDescriptor(key: { $0.type }, {

    $0.localizedCompare($1) == .orderedAscending
})

let lengthDescriptor2: SortDescriptor<Episodes> = makeDescriptor(key: { $0.length }, <)

//episodes.sorted(by: typeDescriptor2).forEach({ print($0 )})

infix operator ▷: LogicalDisjunctionPrecedence

func ▷<T>(l: @escaping SortDescriptor<T>,
            r: @escaping SortDescriptor<T>) -> SortDescriptor<T> {
    return {

        if l($0, $1) {

            return true
        }

        if l($1, $0) {
            return false
        }

        if r($0, $1) {
            return true
        }

        return false

    }
}

func combine<T>(rules: [SortDescriptor<T>]) -> SortDescriptor<T> {

    return { l, r in

        for rule in rules {

            if rule(l, r) {

                return true
            }

            if rule(r, l) {

                return false
            }
        }

        return false
    }
    
}

let mixDescriptor = combine(rules: [typeDescriptor2, lengthDescriptor2])

//episode.sorted(by: mixDescriptor ).forEach({ print($0) })
episode.sorted(by: typeDescriptor2 ▷ lengthDescriptor2 ).forEach({ print($0) })

let numbers = ["Five", "4", "3", "2", "1"]

let intDescriptor: SortDescriptor<String> = makeDescriptor(key: { Int($0) },  shift(<))

print(numbers.sorted(by: intDescriptor))

