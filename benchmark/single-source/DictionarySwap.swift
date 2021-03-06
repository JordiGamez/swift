//===--- DictionarySwap.swift ---------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// Dictionary element swapping benchmark
// rdar://problem/19804127
import TestsUtils

@inline(never)
public func run_DictionarySwap(N: Int) {
    let size = 100
    var dict = [Int: Int](minimumCapacity: size)

    // Fill dictionary
    for i in 1...size {
        dict[i] = i
    }
    CheckResults(dict.count == size,
                 "Incorrect dict count: \(dict.count) != \(size).")

    var swapped = false
    for _ in 1...10000*N {
        swap(&dict[25]!, &dict[75]!)
        swapped = !swapped
        if !swappedCorrectly(swapped, dict[25]!, dict[75]!) {
            break
        }
    }

    CheckResults(swappedCorrectly(swapped, dict[25]!, dict[75]!),
                 "Dictionary value swap failed")
}

// Return true if correctly swapped, false otherwise
func swappedCorrectly(swapped: Bool, _ p25: Int, _ p75: Int) -> Bool {
    return swapped && (p25 == 75 && p75 == 25) ||
          !swapped && (p25 == 25 && p75 == 75)
}
