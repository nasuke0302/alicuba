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
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "nutrientes")
@NamedQueries({
    @NamedQuery(name = "Nutrientes.findAll", query = "SELECT n FROM Nutrientes n")})
public class Nutrientes implements Serializable {

    @OneToMany(mappedBy = "idNutriente")
    private List<Formulas> formulasList;
    @OneToMany(mappedBy = "idNutriente")
    private List<VariablesFormulas> variablesFormulasList;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "nutrientes")
    private List<TablaCnaGeneral> tablaCnaGeneralList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_nutriente")
    private Integer idNutriente;
    @Column(name = "abreviatura")
    private String abreviatura;
    @Column(name = "nombre")
    private String nombre;
    @JoinColumn(name = "id_tipos_datos_alimentos", referencedColumnName = "id_tipos_datos_alimentos")
    @ManyToOne(optional = false)
//    @JsonIgnore
    private TiposDatosAlimentos idTiposDatosAlimentos;
    @JoinColumn(name = "id_unidad_medida", referencedColumnName = "id_unidad_medida")
    @ManyToOne(optional = false)
    private UnidadesMedida idUnidadMedida;

    public Nutrientes() {
    }

    public Nutrientes(Integer idNutriente) {
        this.idNutriente = idNutriente;
    }

    public Integer getIdNutriente() {
        return idNutriente;
    }

    public void setIdNutriente(Integer idNutriente) {
        this.idNutriente = idNutriente;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public TiposDatosAlimentos getIdTiposDatosAlimentos() {
        return idTiposDatosAlimentos;
    }

    public void setIdTiposDatosAlimentos(TiposDatosAlimentos idTiposDatosAlimentos) {
        this.idTiposDatosAlimentos = idTiposDatosAlimentos;
    }

    public UnidadesMedida getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public void setIdUnidadMedida(UnidadesMedida idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idNutriente != null ? idNutriente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Nutrientes)) {
            return false;
        }
        Nutrientes other = (Nutrientes) object;
        if ((this.idNutriente == null && other.idNutriente != null) || (this.idNutriente != null && !this.idNutriente.equals(other.idNutriente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Nutrientes[ idNutriente=" + idNutriente + " ]";
    }

    @XmlTransient
    public List<TablaCnaGeneral> getTablaCnaGeneralList() {
        return tablaCnaGeneralList;
    }

    public void setTablaCnaGeneralList(List<TablaCnaGeneral> tablaCnaGeneralList) {
        this.tablaCnaGeneralList = tablaCnaGeneralList;
    }

    @XmlTransient
    public List<Formulas> getFormulasList() {
        return formulasList;
    }

    public void setFormulasList(List<Formulas> formulasList) {
        this.formulasList = formulasList;
    }

    @XmlTransient
    public List<VariablesFormulas> getVariablesFormulasList() {
        return variablesFormulasList;
    }

    public void setVariablesFormulasList(List<VariablesFormulas> variablesFormulasList) {
        this.variablesFormulasList = variablesFormulasList;
    }

}
