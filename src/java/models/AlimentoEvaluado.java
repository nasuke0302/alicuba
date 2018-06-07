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
 * @author Feisy
 */
@Entity
@Table(name = "alimento_evaluado")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AlimentoEvaluado.findAll", query = "SELECT a FROM AlimentoEvaluado a"),
    @NamedQuery(name = "AlimentoEvaluado.findByIdMetadatosEvaluado", query = "SELECT a FROM AlimentoEvaluado a WHERE a.idMetadatosEvaluado = :idMetadatosEvaluado"),
    @NamedQuery(name = "AlimentoEvaluado.findById", query = "SELECT a FROM AlimentoEvaluado a WHERE a.id = :id")})
public class AlimentoEvaluado implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "id_metadatos_evaluado")
    private Integer idMetadatosEvaluado;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    public AlimentoEvaluado() {
    }

    public AlimentoEvaluado(Integer id) {
        this.id = id;
    }

    public Integer getIdMetadatosEvaluado() {
        return idMetadatosEvaluado;
    }

    public void setIdMetadatosEvaluado(Integer idMetadatosEvaluado) {
        this.idMetadatosEvaluado = idMetadatosEvaluado;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AlimentoEvaluado)) {
            return false;
        }
        AlimentoEvaluado other = (AlimentoEvaluado) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.AlimentoEvaluado[ id=" + id + " ]";
    }
    
}
