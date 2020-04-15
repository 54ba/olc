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
public class CompetitionSolution {
    private int id;
    private String code;
    private int team_id;
    private int competition_id;
    private int problem_id;
    private int language_id;
    private List<CompetitionTestCaseResult> competition_test_case_result_list = new ArrayList<CompetitionTestCaseResult>();
    private int status;
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
      public void setTeamId(int team_id) {
        this.team_id = team_id;
    }
     public int getTeamId() {
        return team_id;
    }
     public void setCompetitionId(int competition_id){
     this.competition_id=competition_id;
     }
     public int getCompetitionId(){
     return competition_id;
     }
  public void setProblemId(int problem_id) {
        this.problem_id = problem_id;
    }
     public int getProblemId() {
        return problem_id;
    }
     public void setLanguageId(int language_id) {
        this.language_id = language_id;
    }
     public int getLanguageId() {
        return language_id;
    }
    
      public void setCompetitionTestCaseResultList(CompetitionTestCaseResult competition_test_case_result) {
        this.competition_test_case_result_list.add(competition_test_case_result);
    }
     public List<CompetitionTestCaseResult> getCompetitionTestCaseResultList() {
        return competition_test_case_result_list;
    }
      public void setStatus(int status) {
        this.status = status;
    }
     public int getStatus() {
        return status;
    }
         public void setError(String error) {
        this.error = error;
    }
     public String getError() {
        return error;
    }
}
