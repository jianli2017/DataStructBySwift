//
//  AC.swift
//  DataStruct
//
//  Created by lijian on 2019/7/16.
//  Copyright © 2019 lijian. All rights reserved.
//

import Foundation


let childrenCount = 26
class AC {
    class ACNode {
        var data: Character  //节点的key
        var children : [ACNode?]  // 指向子节点的数组，字符集只包含 a~z 这 26 个字符
        var isEndingChar = false //结尾字符为true
        var length = -1  //当isEndingChar= true时，记录模式串的长度
        var fail:ACNode? // 失败指针
        init(data:Character) {
            self.data = data
            self.children = Array(repeating: nil, count: childrenCount)
        }
        
        static func == (lhs: ACNode, rhs: ACNode) -> Bool {
            if lhs.data == rhs.data {
                return true
            }
            return false
        }
    }
    
    func buildFailurePoint() {
        var queue:[ACNode] = Array()
        root.fail = nil
        queue.append(root)
        while !queue.isEmpty {
            let p = queue.removeFirst()
            for i in 0..<26 {
                let pc = p.children[i]  //p的子节点
                if pc == nil { //如果当前节点没有值，当然没有必要求失败指针了
                    continue
                }
                if p == root { //如果父节点，第二层，没必要循环了，直接设置为root
                    pc!.fail = root
                } else {
                    var q:ACNode? = p.fail
                    while q != nil {
                        let qc = q?.children[pc!.data.toInt() - Character("a").toInt()]
                        if qc != nil {
                            pc?.fail = qc
                            break
                        }
                        q = q!.fail  //循环的根节点吧
                    }
                    if q == nil {
                        pc?.fail = root
                    }
                }
                queue.append(pc!)
            } //end for
        }//end while
    }
    var root:ACNode = ACNode(data: Character("/"))
    
    func insert(text: String) {
        var p = root
        for i in 0..<text.count {
            let index:Int = text[text.index(text.startIndex, offsetBy: i)].toInt() - Character("a").toInt()
            if p.children[index] == nil {
                let newNode = ACNode(data: text[text.index(text.startIndex, offsetBy: i)])
                p.children[index] = newNode
            }
            p = p.children[index]!
        }
        p.isEndingChar = true;
        p.length = text.count
    }
    
    func mach(text: String) {
        let n = text.count
        var p: ACNode? = root
        for i in 0..<n { //for里面p不可能为nil
            let index = text[text.index(text.startIndex, offsetBy: i)].toInt() - Character("a").toInt()
            while p?.children[index] == nil && p !== root {  //向树根节点移动，找最长后缀
                p = p?.fail!  // 失败指针发挥作用的地方
            }
            
            //下面逻辑处理匹配情况， p增加
            p = p?.children[index]
            if p == nil {
                p = root // 如果没有匹配的，从 root 开始重新匹配
            }
            
            var tmp = p!
            while tmp !== root {
                if tmp.isEndingChar == true {
                    let pos = i - tmp.length + 1
                    print("匹配的起始下标 \(pos) length=\(tmp.length)")
                }
                tmp = tmp.fail!;
            }
        }
    }
    
    static func textAC() {
        let ac = AC()
        ac.insert(text: "li")
        ac.insert(text: "lili")
        ac.insert(text: "jian")
        ac.buildFailurePoint()
        ac.mach(text: "lili")
        print("end")
    }
}
/*
public void match(char[] text) { // text 是主串
    int n = text.length;
    AcNode p = root;
    for (int i = 0; i < n; ++i) {
        int idx = text[i] - 'a';
        while (p.children[idx] == null && p != root) {
            p = p.fail; // 失败指针发挥作用的地方
        }
        p = p.children[idx];
        if (p == null) p = root; // 如果没有匹配的，从 root 开始重新匹配
        AcNode tmp = p;
        while (tmp != root) { // 打印出可以匹配的模式串
            if (tmp.isEndingChar == true) {
                int pos = i-tmp.length+1;
                System.out.println(" 匹配起始下标 " + pos + "; 长度 " + tmp.length);
            }
            tmp = tmp.fail;
        }
    }
}
 */
/*
public class Trie {
    private TrieNode root = new TrieNode('/'); // 存储无意义字符
    
    // 往 Trie 树中插入一个字符串
    public void insert(char[] text) {
        TrieNode p = root;
        for (int i = 0; i < text.length; ++i) {
            int index = text[i] - 'a';
            if (p.children[index] == null) {
                TrieNode newNode = new TrieNode(text[i]);
                p.children[index] = newNode;
            }
            p = p.children[index];
        }
        p.isEndingChar = true;
    }
    
    // 在 Trie 树中查找一个字符串
    public boolean find(char[] pattern) {
    TrieNode p = root;
    for (int i = 0; i < pattern.length; ++i) {
    int index = pattern[i] - 'a';
    if (p.children[index] == null) {
    return false; // 不存在 pattern
    }
    p = p.children[index];
    }
    if (p.isEndingChar == false) return false; // 不能完全匹配，只是前缀
    else return true; // 找到 pattern
    }
    
    public class TrieNode {
        public char data;
        public TrieNode[] children = new TrieNode[26];
        public boolean isEndingChar = false;
        public TrieNode(char data) {
        this.data = data;
        }
    }
}*/


