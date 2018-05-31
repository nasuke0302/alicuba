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
@Table(name = "fertilizado")
@NamedQueries({
    @NamedQuery(name = "Fertilizado.findAll", query = "SELECT f FROM Fertilizado f")})
public class Fertilizado implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "fertilizado")
    private List<MetadatosAlimentosTabla> metadatosAlimentosTablaList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_fertilizado")
    private Integer idFertilizado;
    @Column(name = "fertilizado")
    private String fertilizado;
    @Column(name = "etiqueta")
    private String etiqueta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "fertilizado")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public Fertilizado() {
    }

    public Fertilizado(Integer idFertilizado) {
        this.idFertilizado = idFertilizado;
    }

    public Integer getIdFertilizado() {
        return idFertilizado;
    }

    public void setIdFertilizado(Integer idFertilizado) {
        this.idFertilizado = idFertilizado;
    }

    public String getFertilizado() {
        return fertilizado;
    }

    public void setFertilizado(String fertilizado) {
        this.fertilizado = fertilizado;
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
        hash += (idFertilizado != null ? idFertilizado.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Fertilizado)) {
            return false;
        }
        Fertilizado other = (Fertilizado) object;
        if ((this.idFertilizado == null && other.idFertilizado != null) || (this.idFertilizado != null && !this.idFertilizado.equals(other.idFertilizado))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Fertilizado[ idFertilizado=" + idFertilizado + " ]";
    }

    @XmlTransient
    public List<MetadatosAlimentosTabla> getMetadatosAlimentosTablaList() {
        return metadatosAlimentosTablaList;
    }

    public void setMetadatosAlimentosTablaList(List<MetadatosAlimentosTabla> metadatosAlimentosTablaList) {
        this.metadatosAlimentosTablaList = metadatosAlimentosTablaList;
    }
    
}
