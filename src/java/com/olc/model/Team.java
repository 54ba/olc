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
public class Team {
    private int id;
    private String name;
    private int leader;
    private List<User> user_list = new ArrayList<User>();
    
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
      public void setLeader(int leader) {
        this.leader = leader;
    }
     public int getLeader() {
        return leader;
    }
     public void setUserList(User user) {
        this.user_list.add(user);
    }
     public List<User> getUserList() {
        return user_list;
    }
     
}
