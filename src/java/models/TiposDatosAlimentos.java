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
@Table(name = "tipos_datos_alimentos")
@NamedQueries({
    @NamedQuery(name = "TiposDatosAlimentos.findAll", query = "SELECT t FROM TiposDatosAlimentos t")})
public class TiposDatosAlimentos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipos_datos_alimentos")
    private Integer idTiposDatosAlimentos;
    @Column(name = "nombre_tipo_dato")
    private String nombreTipoDato;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTiposDatosAlimentos")
    @JsonIgnore
    private List<Nutrientes> nutrientesList;

    public TiposDatosAlimentos() {
    }

    public TiposDatosAlimentos(Integer idTiposDatosAlimentos) {
        this.idTiposDatosAlimentos = idTiposDatosAlimentos;
    }

    public Integer getIdTiposDatosAlimentos() {
        return idTiposDatosAlimentos;
    }

    public void setIdTiposDatosAlimentos(Integer idTiposDatosAlimentos) {
        this.idTiposDatosAlimentos = idTiposDatosAlimentos;
    }

    public String getNombreTipoDato() {
        return nombreTipoDato;
    }

    public void setNombreTipoDato(String nombreTipoDato) {
        this.nombreTipoDato = nombreTipoDato;
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
        hash += (idTiposDatosAlimentos != null ? idTiposDatosAlimentos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TiposDatosAlimentos)) {
            return false;
        }
        TiposDatosAlimentos other = (TiposDatosAlimentos) object;
        if ((this.idTiposDatosAlimentos == null && other.idTiposDatosAlimentos != null) || (this.idTiposDatosAlimentos != null && !this.idTiposDatosAlimentos.equals(other.idTiposDatosAlimentos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.TiposDatosAlimentos[ idTiposDatosAlimentos=" + idTiposDatosAlimentos + " ]";
    }
    
}
