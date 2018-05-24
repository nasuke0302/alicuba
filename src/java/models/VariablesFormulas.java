/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "variables_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VariablesFormulas.findAll", query = "SELECT v FROM VariablesFormulas v")
    , @NamedQuery(name = "VariablesFormulas.findByIdVariable", query = "SELECT v FROM VariablesFormulas v WHERE v.idVariable = :idVariable")
    , @NamedQuery(name = "VariablesFormulas.findByVariable", query = "SELECT v FROM VariablesFormulas v WHERE v.variable = :variable")})
public class VariablesFormulas implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_variable")
    private Integer idVariable;
    @Size(max = 2147483647)
    @Column(name = "variable")
    private String variable;
    @JoinColumn(name = "id_formula", referencedColumnName = "id_formula")
    @ManyToOne
    private Formulas idFormula;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente")
    @ManyToOne
    private Nutrientes idNutriente;

    public VariablesFormulas() {
    }

    public VariablesFormulas(Integer idVariable) {
        this.idVariable = idVariable;
    }

    public Integer getIdVariable() {
        return idVariable;
    }

    public void setIdVariable(Integer idVariable) {
        this.idVariable = idVariable;
    }

    public String getVariable() {
        return variable;
    }

    public void setVariable(String variable) {
        this.variable = variable;
    }

    public Formulas getIdFormula() {
        return idFormula;
    }

    public void setIdFormula(Formulas idFormula) {
        this.idFormula = idFormula;
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
        hash += (idVariable != null ? idVariable.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VariablesFormulas)) {
            return false;
        }
        VariablesFormulas other = (VariablesFormulas) object;
        if ((this.idVariable == null && other.idVariable != null) || (this.idVariable != null && !this.idVariable.equals(other.idVariable))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.VariablesFormulas[ idVariable=" + idVariable + " ]";
    }
    
}
