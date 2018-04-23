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
@Table(name = "nivel_fert")
@NamedQueries({
    @NamedQuery(name = "NivelFert.findAll", query = "SELECT n FROM NivelFert n")})
public class NivelFert implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_nivel_fert")
    private Integer idNivelFert;
    @Column(name = "nivel")
    private String nivel;
    @Column(name = "etiqueta")
    private String etiqueta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idNivelFert")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public NivelFert() {
    }

    public NivelFert(Integer idNivelFert) {
        this.idNivelFert = idNivelFert;
    }

    public Integer getIdNivelFert() {
        return idNivelFert;
    }

    public void setIdNivelFert(Integer idNivelFert) {
        this.idNivelFert = idNivelFert;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
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
        hash += (idNivelFert != null ? idNivelFert.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof NivelFert)) {
            return false;
        }
        NivelFert other = (NivelFert) object;
        if ((this.idNivelFert == null && other.idNivelFert != null) || (this.idNivelFert != null && !this.idNivelFert.equals(other.idNivelFert))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.NivelFert[ idNivelFert=" + idNivelFert + " ]";
    }
    
}
