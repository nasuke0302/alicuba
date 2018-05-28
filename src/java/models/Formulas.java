/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Formulas.findAll", query = "SELECT f FROM Formulas f")
    , @NamedQuery(name = "Formulas.findByIdFormula", query = "SELECT f FROM Formulas f WHERE f.idFormula = :idFormula")
    , @NamedQuery(name = "Formulas.findByNombreFormula", query = "SELECT f FROM Formulas f WHERE f.nombreFormula = :nombreFormula")
    , @NamedQuery(name = "Formulas.findByFormula", query = "SELECT f FROM Formulas f WHERE f.formula = :formula")})
public class Formulas implements Serializable {

    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne
    private Usuarios idUsuario;

    @JoinTable(name = "variables_por_formulas", joinColumns = {
        @JoinColumn(name = "id_formula", referencedColumnName = "id_formula")}, inverseJoinColumns = {
        @JoinColumn(name = "id_variable", referencedColumnName = "id_variable")})
    @ManyToMany
    private List<Variables> variablesList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_formula")
    private Integer idFormula;
    @Size(max = 2147483647)
    @Column(name = "nombre_formula")
    private String nombreFormula;
    @Size(max = 2147483647)
    @Column(name = "formula")
    private String formula;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente")
    @ManyToOne
    private Nutrientes idNutriente;

    public Formulas() {
    }

    public Formulas(Integer idFormula) {
        this.idFormula = idFormula;
    }

    public Integer getIdFormula() {
        return idFormula;
    }

    public void setIdFormula(Integer idFormula) {
        this.idFormula = idFormula;
    }

    public String getNombreFormula() {
        return nombreFormula;
    }

    public void setNombreFormula(String nombreFormula) {
        this.nombreFormula = nombreFormula;
    }

    public String getFormula() {
        return formula;
    }

    public void setFormula(String formula) {
        this.formula = formula;
    }

    public Nutrientes getIdNutriente() {
        return idNutriente;
    }

    public void setIdNutriente(Nutrientes idNutriente) {
        this.idNutriente = idNutriente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idFormula != null ? idFormula.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Formulas)) {
            return false;
        }
        Formulas other = (Formulas) object;
        if ((this.idFormula == null && other.idFormula != null) || (this.idFormula != null && !this.idFormula.equals(other.idFormula))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "idformula:" + idFormula + ", nombreFormula: " + nombreFormula + ", formula: " + formula + ", idNutriente: " + idNutriente;
    }

    @XmlTransient
    public List<Variables> getVariablesList() {
        return variablesList;
    }

    public void setVariablesList(List<Variables> variablesList) {
        this.variablesList = variablesList;
    }

    public Usuarios getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuarios idUsuario) {
        this.idUsuario = idUsuario;
    }
    
}
