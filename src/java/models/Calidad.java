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
@Table(name = "calidad")
@NamedQueries({
    @NamedQuery(name = "Calidad.findAll", query = "SELECT c FROM Calidad c")})
public class Calidad implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "calidad")
    private List<MetadatosAlimentosTabla> metadatosAlimentosTablaList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_calidad")
    private Integer idCalidad;
    @Column(name = "calidad")
    private String calidad;
    @Column(name = "etiqueta")
    private String etiqueta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "calidad")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public Calidad() {
    }

    public Calidad(Integer idCalidad) {
        this.idCalidad = idCalidad;
    }

    public Integer getIdCalidad() {
        return idCalidad;
    }

    public void setIdCalidad(Integer idCalidad) {
        this.idCalidad = idCalidad;
    }

    public String getCalidad() {
        return calidad;
    }

    public void setCalidad(String calidad) {
        this.calidad = calidad;
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
        hash += (idCalidad != null ? idCalidad.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Calidad)) {
            return false;
        }
        Calidad other = (Calidad) object;
        if ((this.idCalidad == null && other.idCalidad != null) || (this.idCalidad != null && !this.idCalidad.equals(other.idCalidad))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Calidad[ idCalidad=" + idCalidad + " ]";
    }

    @XmlTransient
    public List<MetadatosAlimentosTabla> getMetadatosAlimentosTablaList() {
        return metadatosAlimentosTablaList;
    }

    public void setMetadatosAlimentosTablaList(List<MetadatosAlimentosTabla> metadatosAlimentosTablaList) {
        this.metadatosAlimentosTablaList = metadatosAlimentosTablaList;
    }
    
}
