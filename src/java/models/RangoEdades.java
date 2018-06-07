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
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "rango_edades")
@NamedQueries({
    @NamedQuery(name = "RangoEdades.findAll", query = "SELECT r FROM RangoEdades r")})
public class RangoEdades implements Serializable {

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idRangoEdades")
    private List<MetadatosAlimentosTabla> metadatosAlimentosTablaList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_rango_edades")
    private Integer idRangoEdades;
    @Column(name = "rango")
    private String rango;
    @Column(name = "etiqueta")
    private String etiqueta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idRangoEdades")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public RangoEdades() {
    }

    public RangoEdades(Integer idRangoEdades) {
        this.idRangoEdades = idRangoEdades;
    }

    public Integer getIdRangoEdades() {
        return idRangoEdades;
    }

    public void setIdRangoEdades(Integer idRangoEdades) {
        this.idRangoEdades = idRangoEdades;
    }

    public String getRango() {
        return rango;
    }

    public void setRango(String rango) {
        this.rango = rango;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public List<MetadatosAlimentosG> getMetadatosAlimentosGList() {
        return metadatosAlimentosGList;
    }

    public void setMetadatosAlimentosGList(List<MetadatosAlimentosG> metadatosAlimentosGList) {
        this.metadatosAlimentosGList = metadatosAlimentosGList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRangoEdades != null ? idRangoEdades.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RangoEdades)) {
            return false;
        }
        RangoEdades other = (RangoEdades) object;
        if ((this.idRangoEdades == null && other.idRangoEdades != null) || (this.idRangoEdades != null && !this.idRangoEdades.equals(other.idRangoEdades))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.RangoEdades[ idRangoEdades=" + idRangoEdades + " ]";
    }

    @XmlTransient
    public List<MetadatosAlimentosTabla> getMetadatosAlimentosTablaList() {
        return metadatosAlimentosTablaList;
    }

    public void setMetadatosAlimentosTablaList(List<MetadatosAlimentosTabla> metadatosAlimentosTablaList) {
        this.metadatosAlimentosTablaList = metadatosAlimentosTablaList;
    }
    
}
