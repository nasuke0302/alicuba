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
@Table(name = "tipo_nrc")
@NamedQueries({
    @NamedQuery(name = "TipoNrc.findAll", query = "SELECT t FROM TipoNrc t")})
public class TipoNrc implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_nrc")
    private Integer idTipoNrc;
    @Column(name = "tipo_nrc")
    private String tipoNrc;
    @Column(name = "detalles")
    private String detalles;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipoNrc")
    @JsonIgnore
    private List<Alimentos> alimentosList;

    public TipoNrc() {
    }

    public TipoNrc(Integer idTipoNrc) {
        this.idTipoNrc = idTipoNrc;
    }

    public Integer getIdTipoNrc() {
        return idTipoNrc;
    }

    public void setIdTipoNrc(Integer idTipoNrc) {
        this.idTipoNrc = idTipoNrc;
    }

    public String getTipoNrc() {
        return tipoNrc;
    }

    public void setTipoNrc(String tipoNrc) {
        this.tipoNrc = tipoNrc;
    }

    public String getDetalles() {
        return detalles;
    }

    public void setDetalles(String detalles) {
        this.detalles = detalles;
    }

    public List<Alimentos> getAlimentosList() {
        return alimentosList;
    }

    public void setAlimentosList(List<Alimentos> alimentosList) {
        this.alimentosList = alimentosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTipoNrc != null ? idTipoNrc.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoNrc)) {
            return false;
        }
        TipoNrc other = (TipoNrc) object;
        if ((this.idTipoNrc == null && other.idTipoNrc != null) || (this.idTipoNrc != null && !this.idTipoNrc.equals(other.idTipoNrc))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.TipoNrc[ idTipoNrc=" + idTipoNrc + " ]";
    }
    
}
