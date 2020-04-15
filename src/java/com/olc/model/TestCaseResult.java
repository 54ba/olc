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
public class TestCaseResult {
  private int id;
  private int passed;
  private String memory_usage;
  private String running_time;
  private int solution_id;
  private int test_case_id;
  
   public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
     
       public void setPassed(int passed) {
        this.passed = passed;
    }
     public int getPassed() {
        return passed;
    }
       public void setMemoryUsage(String memory_usage){
        this.memory_usage=memory_usage;
    }
     public String getMemoryUsage(){
        return memory_usage;
    }
       public void setRunningTime(String running_time){
        this.running_time=running_time;
    }
     public String getRunningTime(){
        return running_time;
    }
     
     
      public void setSolutionId(int solution_id) {
        this.solution_id = solution_id;
    }
     public int getSolutionId() {
        return solution_id;
    }
     
      public void setTestCaseId(int test_case_id) {
        this.test_case_id = test_case_id;
    }
     public int getTestCaseId() {
        return test_case_id;
    }
}
