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
@Table(name = "paises")
@NamedQueries({
    @NamedQuery(name = "Paises.findAll", query = "SELECT p FROM Paises p")})
public class Paises implements Serializable {

    @JsonIgnore
    @OneToMany(mappedBy = "import1")
    private List<MetadatosAlimentosTabla> metadatosAlimentosTablaList;

    @Column(name = "pais")
    private String pais;
    @Column(name = "alpha3")
    private String alpha3;
    @Column(name = "alpha2")
    private String alpha2;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_paises")
    private Integer idPaises;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "import1")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public Paises() {
    }

    public Paises(Integer idPaises) {
        this.idPaises = idPaises;
    }

    public Integer getIdPaises() {
        return idPaises;
    }

    public void setIdPaises(Integer idPaises) {
        this.idPaises = idPaises;
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
        hash += (idPaises != null ? idPaises.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Paises)) {
            return false;
        }
        Paises other = (Paises) object;
        if ((this.idPaises == null && other.idPaises != null) || (this.idPaises != null && !this.idPaises.equals(other.idPaises))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Paises[ idPaises=" + idPaises + " ]";
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getAlpha3() {
        return alpha3;
    }

    public void setAlpha3(String alpha3) {
        this.alpha3 = alpha3;
    }

    public String getAlpha2() {
        return alpha2;
    }

    public void setAlpha2(String alpha2) {
        this.alpha2 = alpha2;
    }

    @XmlTransient
    public List<MetadatosAlimentosTabla> getMetadatosAlimentosTablaList() {
        return metadatosAlimentosTablaList;
    }

    public void setMetadatosAlimentosTablaList(List<MetadatosAlimentosTabla> metadatosAlimentosTablaList) {
        this.metadatosAlimentosTablaList = metadatosAlimentosTablaList;
    }
    
}
