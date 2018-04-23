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
@Table(name = "tipo_cuba")
@NamedQueries({
    @NamedQuery(name = "TipoCuba.findAll", query = "SELECT t FROM TipoCuba t")})
public class TipoCuba implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_cuba")
    private Integer idTipoCuba;
    @Column(name = "tipo_cuba")
    private String tipoCuba;
    @Column(name = "detalles")
    private String detalles;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipoCuba")
    @JsonIgnore
    private List<Alimentos> alimentosList;

    public TipoCuba() {
    }

    public TipoCuba(Integer idTipoCuba) {
        this.idTipoCuba = idTipoCuba;
    }

    public Integer getIdTipoCuba() {
        return idTipoCuba;
    }

    public void setIdTipoCuba(Integer idTipoCuba) {
        this.idTipoCuba = idTipoCuba;
    }

    public String getTipoCuba() {
        return tipoCuba;
    }

    public void setTipoCuba(String tipoCuba) {
        this.tipoCuba = tipoCuba;
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
        hash += (idTipoCuba != null ? idTipoCuba.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoCuba)) {
            return false;
        }
        TipoCuba other = (TipoCuba) object;
        if ((this.idTipoCuba == null && other.idTipoCuba != null) || (this.idTipoCuba != null && !this.idTipoCuba.equals(other.idTipoCuba))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.TipoCuba[ idTipoCuba=" + idTipoCuba + " ]";
    }
    
}
