//
//  17_电话号码的字母组合.swift
//  DataStruct
//
//  Created by lijian on 2019/7/29.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation

/*
给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。

给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。



示例:

输入："23"
输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
说明:
尽管上面的答案是按字典序排列的，但是你可以任意选择答案输出的顺序。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


class solution_17_电话号码的字母组合 {
    let phone = [
        "2":"abc",
        "3":"def",
        "4":"ghi",
        "5":"jkl",
        "6":"mno",
        "7":"pqrs",
        "8":"tuv",
        "9":"wxyz"
    ]
    
    var output = [String]()
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count > 0 {
            backtrack("", digits)
        }
        return output
    }
    
    func backtrack(_ combination: String, _ next_digitts: String)  {
        if next_digitts.count == 0 {
            output.append(combination)
        } else {
            let digit = String(next_digitts.prefix(1))
            let letters = phone[digit]!
            for i in 0..<letters.count {
                let index = letters.index(letters.startIndex, offsetBy: i)
                let endIndex = letters.index(after: index)
                let letter = letters[index ..< endIndex]
                backtrack(combination + letter, String(next_digitts[next_digitts.index(after: next_digitts.startIndex)..<next_digitts.endIndex]))
            }
        }
    }
}

extension solution_17_电话号码的字母组合 {
    static func test() {
        let instance = solution_17_电话号码的字母组合()
        print(instance.letterCombinations("23"))
    }
}
/*


List<String> output = new ArrayList<String>();

public void backtrack(String combination, String next_digits) {
    // if there is no more digits to check
    if (next_digits.length() == 0) {
        // the combination is done
        output.add(combination);
    }
        // if there are still digits to check
    else {
        // iterate over all letters which map
        // the next available digit
        String digit = next_digits.substring(0, 1);
        String letters = phone.get(digit);
        for (int i = 0; i < letters.length(); i++) {
            String letter = phone.get(digit).substring(i, i + 1);
            // append the current letter to the combination
            // and proceed to the next digits
            backtrack(combination + letter, next_digits.substring(1));
        }
    }
}

public List<String> letterCombinations(String digits) {
    if (digits.length() != 0)
    backtrack("", digits);
    return output;
}

作者：LeetCode
链接：https://leetcode-cn.com/problems/two-sum/solution/dian-hua-hao-ma-de-zi-mu-zu-he-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/
