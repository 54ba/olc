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
public class CompetitionPoints {
     private int id;
     private int problem_id;
     private int competition_id	;
     private int team_id;
     
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
       public void setCompetitionId(int competition_id) {
        this.competition_id = competition_id;
    }
     public int getCompetitionId() {
        return competition_id;
    }
     
      public void setTeamId(int team_id) {
        this.team_id = team_id;
    }
     public int getTeamId() {
        return team_id;
    }
     
     
}
