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


public class User {

    private int id;
    private String username;
    private String password;
    private String name;
    private int team_id;
    private int score;
    private int leader;
    private int rank;
    private int role;

    //role 0 user 1 admin 2 validator 3 competition creator


    

   
    public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
     
      public void setUsername(String username) {
        this.username = username;
    }
     
    public String getUsername() {
        return username;
    }
    
    public void setPassword(String password){
        this.password=password;
    }
     public String getPassword(){
        return password;
    }
      public void setName(String name){
        this.name=name;
    }
     public String getName(){
        return name;
    }
     
       public void setTeamId(int team_id){
         this.team_id=team_id;

     }
       public int getTeamId(){
        return team_id;
    }
     
     public void setScore(int score){
        this.score=score;
    }
     public int getScore(){
        return score;
    }
     
       public void setLeader(int leader) {
        this.leader = leader;
    }
     public int getLeader() {
        return leader;
    }
    public void setRank(int rank){
        this.rank=rank;
    }
     public int getRank(){
        return rank;
    }
      public void setRole(int role){
        this.role=role;
    }
     public int getRole(){
        return role;
    }
   
    @Override
    public String toString() {
        return "user"+ getUsername();
    }    
}
