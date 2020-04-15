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
public class Problem {
    private int id;
    private String title;
    private String description;
 
    private String sample_input;
    private String sample_output;
    private int validated;
    private String complexity;
    private int scope;
    private int points;
    private String c_code;
    private String java_code;
    private String cplus_code;


    private List<TestCase> test_case_list = new ArrayList<TestCase>();

     public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
       public void setTitle(String title){
        this.title=title;
    }
     public String getTitle(){
        return title;
    }
      public void setDescription(String description){
        this.description=description;
    }
     public String getDescription(){
        return description;
    }


 public void setSampleInput(String sample_input){
        this.sample_input=sample_input;
    }
     public String getSampleInput(){
        return sample_input;
    }


 public void setSampleOutput(String sample_output){
        this.sample_output=sample_output;
    }
     public String getSampleOutput(){
        return sample_output;
    }

      public void setValidated(int validated) {
        this.validated = validated;
    }
     public int getValidated() {
        return validated;
    }
     
      public void setTestCaseList(TestCase test_case) {
        this.test_case_list.add(test_case);
    }
     public List<TestCase> getTestCaseList() {
        return test_case_list;
    }
     public void setComplexity(String complexity){
        this.complexity=complexity;
    }
     public String getComplexity(){
        return complexity;
    }
     public void setScope(int scope) {
        this.scope = scope;
    }
     public int getScope() {
        return scope;
    }
     public void setPoints(int points) {
        this.points = points;
    }
     public int getPoints() {
        return points;
    }
      public void setCCode(String c_code){
        this.c_code=c_code;
    }
     public String getCCode(){
        return c_code;
    }
      public void setCplusCode(String cplus_code){
        this.cplus_code=cplus_code;
    }
     public String getCplusCode(){
        return cplus_code;
    }
      public void setJavaCode(String java_code){
        this.java_code=java_code;
    }
     public String getJavaCode(){
        return java_code;
    }
}
