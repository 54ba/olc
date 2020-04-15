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
public class TeamCompetition {
      private int id;
      private int team_id;
      private int competition_id;
      private int score;
      private String team_name;
      private int rank;



        public void setId(int id) {
        this.id = id;
    }
     public int getId() {
        return id;
    }
     
       public void setTeamId(int team_id) {
        this.team_id = team_id;
    }
     public int getTeamId() {
        return team_id;
    }
     
        public void setCompetitionId(int competition_id) {
        this.competition_id = competition_id;
    }
     public int getCompetitionId() {
        return competition_id;
    }

      
        public void setScore(int score) {
        this.score = score;
    }
     public int getScore() {
        return score;
    }

    public void setTeamName(String team_name) {
     this.team_name = team_name;
    }
    public String getTeamName(){
        return team_name;
    }
        public void setRank(int rank) {
        this.rank = rank;
    }
     public int getRank() {
        return rank;
    }

}
