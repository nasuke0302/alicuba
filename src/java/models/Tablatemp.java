/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Tesis
 */
@Entity
@Table(name = "tablatemp")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tablatemp.findAll", query = "SELECT t FROM Tablatemp t")
    , @NamedQuery(name = "Tablatemp.findByIdTablatemp", query = "SELECT t FROM Tablatemp t WHERE t.idTablatemp = :idTablatemp")
    , @NamedQuery(name = "Tablatemp.findByValores", query = "SELECT t FROM Tablatemp t WHERE t.valores = :valores")})
public class Tablatemp implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tablatemp")
    private Integer idTablatemp;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valores")
    private Float valores;

    public Tablatemp() {
    }

    public Tablatemp(Integer idTablatemp) {
        this.idTablatemp = idTablatemp;
    }

    public Integer getIdTablatemp() {
        return idTablatemp;
    }

    public void setIdTablatemp(Integer idTablatemp) {
        this.idTablatemp = idTablatemp;
    }

    public Float getValores() {
        return valores;
    }

    public void setValores(Float valores) {
        this.valores = valores;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTablatemp != null ? idTablatemp.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tablatemp)) {
            return false;
        }
        Tablatemp other = (Tablatemp) object;
        if ((this.idTablatemp == null && other.idTablatemp != null) || (this.idTablatemp != null && !this.idTablatemp.equals(other.idTablatemp))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.TablaTemp[ idTablatemp=" + idTablatemp + " ]";
    }
    
}
