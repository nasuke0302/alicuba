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
@Table(name = "paises")
@NamedQueries({
    @NamedQuery(name = "Paises.findAll", query = "SELECT p FROM Paises p")})
public class Paises implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "nombre")
    private String nombre;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_paises")
    private Integer idPaises;
    @Column(name = "etiqueta")
    private String etiqueta;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "import1")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public Paises() {
    }

    public Paises(Integer idPaises) {
        this.idPaises = idPaises;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getIdPaises() {
        return idPaises;
    }

    public void setIdPaises(Integer idPaises) {
        this.idPaises = idPaises;
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
    
}
