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
public class TestCase {
  private int id;
  private String input;
  private String output;
  private int problem_id;
  
   public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
     
     public void setInput(String input){
        this.input=input;
    }
     public String getInput(){
        return input;
    }
     
     public void setOutput(String output){
        this.output=output;
    }
     public String getOutput(){
        return output;
    }
     
      public void setProblemId(int problem_id) {
        this.problem_id = problem_id;
    }
     public int getProblemId() {
        return problem_id;
    }

}
