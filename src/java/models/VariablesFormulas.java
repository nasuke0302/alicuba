/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
public class VariablesFormulas implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_variable")
    private Integer idVariable;
    @JoinColumn(name = "id_formula", referencedColumnName = "id_formula")
    @JsonIgnore
    @ManyToOne
    private Formulas idFormula;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente")
    @ManyToOne
    private Nutrientes idNutriente;
    @Size(max = 2147483647)
    @Column(name = "nombres_variable")
    private String nombresVariable;

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

    public String getNombresVariable() {
        return nombresVariable;
    }

    public void setNombresVariable(String nombresVariables) {
        this.nombresVariable = nombresVariables;
    }

}
