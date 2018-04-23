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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "tabla_cna_general")
@NamedQueries({
    @NamedQuery(name = "TablaCnaGeneral.findAll", query = "SELECT t FROM TablaCnaGeneral t")})
public class TablaCnaGeneral implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valor")
    private Float valor;
    @Id
    @Basic(optional = false)
    @Column(name = "id_metadatos_alimentos_g")
    private Integer idMetadatosAlimentosG;
    @JoinColumn(name = "id_metadatos_alimentos_g", referencedColumnName = "id_metadatos_alimentos_g", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private MetadatosAlimentosG metadatosAlimentosG;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente")
    @ManyToOne(optional = false)
    private Nutrientes idNutriente;

    public TablaCnaGeneral() {
    }

    public TablaCnaGeneral(Integer idMetadatosAlimentosG) {
        this.idMetadatosAlimentosG = idMetadatosAlimentosG;
    }

    public Float getValor() {
        return valor;
    }

    public void setValor(Float valor) {
        this.valor = valor;
    }

    public Integer getIdMetadatosAlimentosG() {
        return idMetadatosAlimentosG;
    }

    public void setIdMetadatosAlimentosG(Integer idMetadatosAlimentosG) {
        this.idMetadatosAlimentosG = idMetadatosAlimentosG;
    }

    public MetadatosAlimentosG getMetadatosAlimentosG() {
        return metadatosAlimentosG;
    }

    public void setMetadatosAlimentosG(MetadatosAlimentosG metadatosAlimentosG) {
        this.metadatosAlimentosG = metadatosAlimentosG;
    }

    public Nutrientes getIdNutriente() {
        return idNutriente;
    }

    public void setIdNutriente(Nutrientes idNutriente) {
        this.idNutriente = idNutriente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMetadatosAlimentosG != null ? idMetadatosAlimentosG.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TablaCnaGeneral)) {
            return false;
        }
        TablaCnaGeneral other = (TablaCnaGeneral) object;
        if ((this.idMetadatosAlimentosG == null && other.idMetadatosAlimentosG != null) || (this.idMetadatosAlimentosG != null && !this.idMetadatosAlimentosG.equals(other.idMetadatosAlimentosG))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.TablaCnaGeneral[ idMetadatosAlimentosG=" + idMetadatosAlimentosG + " ]";
    }
    
}
