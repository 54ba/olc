/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.model;

import java.util.Date;


/**
 *
 * @author mahmoud
 */
public class Competition {
    private int id;
    private String name;
    private Date start_date;
    private Date end_date;
    private int creator;
    
    
    public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
     
       public void setName(String name){
        this.name=name;
    }
     public String getName(){
        return name;
    }
      public void setStartDate(Date start_date){
        this.start_date=start_date;
    }
     public Date getStartDate(){
        return start_date;
    }
      public void setEndDate(Date end_date){
        this.end_date=end_date;
    }
     public Date getEndDate(){
        return end_date;
    }
     
      public void setCreator(int creator){
        this.creator=creator;
    }
     public int getCreator(){
        return creator;
    }

}
