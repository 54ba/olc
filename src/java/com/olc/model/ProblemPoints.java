/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.model;

/**
 *
 * @author mahmoud
 */
public class ProblemPoints {
     private int id;
     private int problem_id;
     private int user_id;
     
      public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
      public void setProblemId(int problem_id) {
        this.problem_id = problem_id;
    }
     public int getProblemId() {
        return problem_id;
    }
        public void setUserId(int user_id) {
        this.user_id = user_id;
    }
     public int getUserId() {
        return user_id;
    }
      
     


}
