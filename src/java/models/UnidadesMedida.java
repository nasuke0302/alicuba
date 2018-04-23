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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "unidades_medida")
@NamedQueries({
    @NamedQuery(name = "UnidadesMedida.findAll", query = "SELECT u FROM UnidadesMedida u")})
public class UnidadesMedida implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_unidad_medida")
    private Integer idUnidadMedida;
    @Column(name = "unidad_medida")
    private String unidadMedida;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idUnidadMedida")
    @JsonIgnore
    private List<Nutrientes> nutrientesList;

    public UnidadesMedida() {
    }

    public UnidadesMedida(Integer idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public Integer getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public void setIdUnidadMedida(Integer idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public String getUnidadMedida() {
        return unidadMedida;
    }

    public void setUnidadMedida(String unidadMedida) {
        this.unidadMedida = unidadMedida;
    }

    public List<Nutrientes> getNutrientesList() {
        return nutrientesList;
    }

    public void setNutrientesList(List<Nutrientes> nutrientesList) {
        this.nutrientesList = nutrientesList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idUnidadMedida != null ? idUnidadMedida.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UnidadesMedida)) {
            return false;
        }
        UnidadesMedida other = (UnidadesMedida) object;
        if ((this.idUnidadMedida == null && other.idUnidadMedida != null) || (this.idUnidadMedida != null && !this.idUnidadMedida.equals(other.idUnidadMedida))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.UnidadesMedida[ idUnidadMedida=" + idUnidadMedida + " ]";
    }
    
}
