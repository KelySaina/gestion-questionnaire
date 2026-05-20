package com.gq.model;

public class Examen {
    private int numExam;
    private String numEtudiant;
    private String anneeUniv;
    private int note;
    private String dateExam;
    // jointure
    private String nomEtudiant;
    private String prenomsEtudiant;
    private String niveauEtudiant;

    public int getNumExam() { return numExam; }
    public void setNumExam(int v) { this.numExam = v; }
    public String getNumEtudiant() { return numEtudiant; }
    public void setNumEtudiant(String v) { this.numEtudiant = v; }
    public String getAnneeUniv() { return anneeUniv; }
    public void setAnneeUniv(String v) { this.anneeUniv = v; }
    public int getNote() { return note; }
    public void setNote(int v) { this.note = v; }
    public String getDateExam() { return dateExam; }
    public void setDateExam(String v) { this.dateExam = v; }
    public String getNomEtudiant() { return nomEtudiant; }
    public void setNomEtudiant(String v) { this.nomEtudiant = v; }
    public String getPrenomsEtudiant() { return prenomsEtudiant; }
    public void setPrenomsEtudiant(String v) { this.prenomsEtudiant = v; }
    public String getNiveauEtudiant() { return niveauEtudiant; }
    public void setNiveauEtudiant(String v) { this.niveauEtudiant = v; }
}
