/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mahmoud
 */
public class Solution {
    private int id;
    private String code;
    private int user_id;
    private int problem_id;
    private List<TestCaseResult> test_case_result_list = new ArrayList<TestCaseResult>();
    private int status;
    private int language_id;
    private String error;

     public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
       public void setCode(String code) {
        this.code = code;
    }
     public String getCode() {
        return code;
    }
      public void setUserId(int user_id) {
        this.user_id = user_id;
    }
     public int getUserId() {
        return user_id;
    }
  public void setProblemId(int problem_id) {
        this.problem_id = problem_id;
    }
     public int getProblemId() {
        return problem_id;
    }
   
    
      public void setTestCaseResultList(TestCaseResult test_case_result) {
        this.test_case_result_list.add(test_case_result);
    }
     public List<TestCaseResult> getTestCaseResultList() {
        return test_case_result_list;
    }
        public void setStatus(int status) {
        this.status = status;
    }
     public int getStatus() {
        return status;
    }
     
        public void setLanguageId(int language_id) {
        this.language_id = language_id;
    }
     public int getLanguageId() {
        return language_id;
    }
         public void setError(String error) {
        this.error = error;
    }
     public String getError() {
        return error;
    }
}
