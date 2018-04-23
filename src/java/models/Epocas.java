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
@Table(name = "epocas")
@NamedQueries({
    @NamedQuery(name = "Epocas.findAll", query = "SELECT e FROM Epocas e")})
public class Epocas implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_epoca")
    private Integer idEpoca;
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "etiqueta")
    private String etiqueta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idEpoca")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public Epocas() {
    }

    public Epocas(Integer idEpoca) {
        this.idEpoca = idEpoca;
    }

    public Integer getIdEpoca() {
        return idEpoca;
    }

    public void setIdEpoca(Integer idEpoca) {
        this.idEpoca = idEpoca;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
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
        hash += (idEpoca != null ? idEpoca.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Epocas)) {
            return false;
        }
        Epocas other = (Epocas) object;
        if ((this.idEpoca == null && other.idEpoca != null) || (this.idEpoca != null && !this.idEpoca.equals(other.idEpoca))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Epocas[ idEpoca=" + idEpoca + " ]";
    }
    
}
