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
@Table(name = "fuente_inf")
@NamedQueries({
    @NamedQuery(name = "FuenteInf.findAll", query = "SELECT f FROM FuenteInf f")})
public class FuenteInf implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_fuente")
    private Integer idFuente;
    @Column(name = "nombre_fuente")
    private String nombreFuente;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idFuente")
    @JsonIgnore
    private List<Referencias> referenciasList;

    public FuenteInf() {
    }
    
    public FuenteInf(Integer idFuente) {
        this.idFuente = idFuente;
    }

    public Integer getIdFuente() {
        return idFuente;
    }

    public void setIdFuente(Integer idFuente) {
        this.idFuente = idFuente;
    }

    public String getNombreFuente() {
        return nombreFuente;
    }

    public void setNombreFuente(String nombreFuente) {
        this.nombreFuente = nombreFuente;
    }

    public List<Referencias> getReferenciasList() {
        return referenciasList;
    }

    public void setReferenciasList(List<Referencias> referenciasList) {
        this.referenciasList = referenciasList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idFuente != null ? idFuente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FuenteInf)) {
            return false;
        }
        FuenteInf other = (FuenteInf) object;
        if ((this.idFuente == null && other.idFuente != null) || (this.idFuente != null && !this.idFuente.equals(other.idFuente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.FuenteInf[ idFuente=" + idFuente + " ]";
    }
    
}
