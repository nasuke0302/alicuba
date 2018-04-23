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
@Table(name = "tipo_fao")
@NamedQueries({
    @NamedQuery(name = "TipoFao.findAll", query = "SELECT t FROM TipoFao t")})
public class TipoFao implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_fao")
    private Integer idTipoFao;
    @Column(name = "tipo_fao")
    private String tipoFao;
    @Column(name = "detalles")
    private String detalles;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipoFao")
    @JsonIgnore
    private List<Alimentos> alimentosList;

    public TipoFao() {
    }

    public TipoFao(Integer idTipoFao) {
        this.idTipoFao = idTipoFao;
    }

    public Integer getIdTipoFao() {
        return idTipoFao;
    }

    public void setIdTipoFao(Integer idTipoFao) {
        this.idTipoFao = idTipoFao;
    }

    public String getTipoFao() {
        return tipoFao;
    }

    public void setTipoFao(String tipoFao) {
        this.tipoFao = tipoFao;
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
        hash += (idTipoFao != null ? idTipoFao.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoFao)) {
            return false;
        }
        TipoFao other = (TipoFao) object;
        if ((this.idTipoFao == null && other.idTipoFao != null) || (this.idTipoFao != null && !this.idTipoFao.equals(other.idTipoFao))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.TipoFao[ idTipoFao=" + idTipoFao + " ]";
    }
    
}
