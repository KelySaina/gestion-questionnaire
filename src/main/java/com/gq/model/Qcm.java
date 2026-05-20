package com.gq.model;

public class Qcm {
    private int numQuest;
    private String question;
    private String reponse1;
    private String reponse2;
    private String reponse3;
    private String reponse4;
    private int bonneReponse;

    public Qcm() {}

    public int getNumQuest() { return numQuest; }
    public void setNumQuest(int v) { this.numQuest = v; }
    public String getQuestion() { return question; }
    public void setQuestion(String v) { this.question = v; }
    public String getReponse1() { return reponse1; }
    public void setReponse1(String v) { this.reponse1 = v; }
    public String getReponse2() { return reponse2; }
    public void setReponse2(String v) { this.reponse2 = v; }
    public String getReponse3() { return reponse3; }
    public void setReponse3(String v) { this.reponse3 = v; }
    public String getReponse4() { return reponse4; }
    public void setReponse4(String v) { this.reponse4 = v; }
    public int getBonneReponse() { return bonneReponse; }
    public void setBonneReponse(int v) { this.bonneReponse = v; }

    public String getReponseTexte(int i) {
        switch (i) {
            case 1: return reponse1;
            case 2: return reponse2;
            case 3: return reponse3;
            case 4: return reponse4;
            default: return null;
        }
    }
}
