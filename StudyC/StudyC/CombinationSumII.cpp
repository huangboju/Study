//
//  CombinationSumII.cpp
//  StudyC
//
//  Created by xiAo_Ju on 2018/11/27.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#include "CombinationSumII.hpp"

#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> combinationSum2(vector<int> &num, int target) {
        vector<vector<int>> allSol;
        if(num.empty()) return allSol;
        sort(num.begin(),num.end());
        vector<int> sol;
        findCombSum2(num, 0, target, sol, allSol);
        return allSol;
    }
    
    void findCombSum2(vector<int> &num, int start, int target, vector<int> &sol, vector<vector<int>> &allSol) {
        if (target == 0) {
            allSol.push_back(sol);
            return;
        }
        
        for (int i = start; i < num.size(); i++) {
            if (i > start && num[i] == num[i-1]) continue;
            if (num[i] <= target) {
                sol.push_back(num[i]);
                findCombSum2(num, i+1, target - num[i], sol, allSol);
                sol.pop_back();
            }
        }
    }
};
