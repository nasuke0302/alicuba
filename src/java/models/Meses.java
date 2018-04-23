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
@Table(name = "meses")
@NamedQueries({
    @NamedQuery(name = "Meses.findAll", query = "SELECT m FROM Meses m")})
public class Meses implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_mes")
    private Integer idMes;
    @Column(name = "mes")
    private String mes;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "mesIni")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "mesFin")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList1;

    public Meses() {
    }

    public Meses(Integer idMes) {
        this.idMes = idMes;
    }

    public Integer getIdMes() {
        return idMes;
    }

    public void setIdMes(Integer idMes) {
        this.idMes = idMes;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public List<MetadatosAlimentosG> getMetadatosAlimentosGList() {
        return metadatosAlimentosGList;
    }

    public void setMetadatosAlimentosGList(List<MetadatosAlimentosG> metadatosAlimentosGList) {
        this.metadatosAlimentosGList = metadatosAlimentosGList;
    }

    public List<MetadatosAlimentosG> getMetadatosAlimentosGList1() {
        return metadatosAlimentosGList1;
    }

    public void setMetadatosAlimentosGList1(List<MetadatosAlimentosG> metadatosAlimentosGList1) {
        this.metadatosAlimentosGList1 = metadatosAlimentosGList1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMes != null ? idMes.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Meses)) {
            return false;
        }
        Meses other = (Meses) object;
        if ((this.idMes == null && other.idMes != null) || (this.idMes != null && !this.idMes.equals(other.idMes))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Meses[ idMes=" + idMes + " ]";
    }
    
}
