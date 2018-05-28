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
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "variables")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Variables.findAll", query = "SELECT v FROM Variables v")
    , @NamedQuery(name = "Variables.findByIdVariable", query = "SELECT v FROM Variables v WHERE v.idVariable = :idVariable")
    , @NamedQuery(name = "Variables.findByNombreVariable", query = "SELECT v FROM Variables v WHERE v.nombreVariable = :nombreVariable")})
public class Variables implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_variable")
    private Integer idVariable;
    @Size(max = 2147483647)
    @Column(name = "nombre_variable")
    private String nombreVariable;
    @JsonIgnore
    @ManyToMany(mappedBy = "variablesList")
    private List<Formulas> formulasList;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente")
    @ManyToOne
    private Nutrientes idNutriente;

    public Variables() {
    }

    public Variables(Integer idVariable) {
        this.idVariable = idVariable;
    }

    public Integer getIdVariable() {
        return idVariable;
    }

    public void setIdVariable(Integer idVariable) {
        this.idVariable = idVariable;
    }

    public String getNombreVariable() {
        return nombreVariable;
    }

    public void setNombreVariable(String nombreVariable) {
        this.nombreVariable = nombreVariable;
    }

    @XmlTransient
    public List<Formulas> getFormulasList() {
        return formulasList;
    }

    public void setFormulasList(List<Formulas> formulasList) {
        this.formulasList = formulasList;
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
        if (!(object instanceof Variables)) {
            return false;
        }
        Variables other = (Variables) object;
        if ((this.idVariable == null && other.idVariable != null) || (this.idVariable != null && !this.idVariable.equals(other.idVariable))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.Variables[ idVariable=" + idVariable + " ]";
    }
    
}
