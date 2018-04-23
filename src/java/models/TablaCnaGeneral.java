/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "tabla_cna_general")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TablaCnaGeneral.findAll", query = "SELECT t FROM TablaCnaGeneral t")
    , @NamedQuery(name = "TablaCnaGeneral.findByIdMetadatosAlimentosG", query = "SELECT t FROM TablaCnaGeneral t WHERE t.tablaCnaGeneralPK.idMetadatosAlimentosG = :idMetadatosAlimentosG")
    , @NamedQuery(name = "TablaCnaGeneral.findByIdNutriente", query = "SELECT t FROM TablaCnaGeneral t WHERE t.tablaCnaGeneralPK.idNutriente = :idNutriente")
    , @NamedQuery(name = "TablaCnaGeneral.findByValor", query = "SELECT t FROM TablaCnaGeneral t WHERE t.valor = :valor")})
public class TablaCnaGeneral implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TablaCnaGeneralPK tablaCnaGeneralPK;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valor")
    private Float valor;
    @JsonIgnore
    @JoinColumn(name = "id_metadatos_alimentos_g", referencedColumnName = "id_metadatos_alimentos_g", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private MetadatosAlimentosG metadatosAlimentosG;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Nutrientes nutrientes;

    public TablaCnaGeneral() {
    }

    public TablaCnaGeneral(TablaCnaGeneralPK tablaCnaGeneralPK) {
        this.tablaCnaGeneralPK = tablaCnaGeneralPK;
    }

    public TablaCnaGeneral(int idMetadatosAlimentosG, int idNutriente) {
        this.tablaCnaGeneralPK = new TablaCnaGeneralPK(idMetadatosAlimentosG, idNutriente);
    }

    public TablaCnaGeneralPK getTablaCnaGeneralPK() {
        return tablaCnaGeneralPK;
    }

    public void setTablaCnaGeneralPK(TablaCnaGeneralPK tablaCnaGeneralPK) {
        this.tablaCnaGeneralPK = tablaCnaGeneralPK;
    }

    public Float getValor() {
        return valor;
    }

    public void setValor(Float valor) {
        this.valor = valor;
    }

    public MetadatosAlimentosG getMetadatosAlimentosG() {
        return metadatosAlimentosG;
    }

    public void setMetadatosAlimentosG(MetadatosAlimentosG metadatosAlimentosG) {
        this.metadatosAlimentosG = metadatosAlimentosG;
    }

    public Nutrientes getNutrientes() {
        return nutrientes;
    }

    public void setNutrientes(Nutrientes nutrientes) {
        this.nutrientes = nutrientes;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tablaCnaGeneralPK != null ? tablaCnaGeneralPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TablaCnaGeneral)) {
            return false;
        }
        TablaCnaGeneral other = (TablaCnaGeneral) object;
        if ((this.tablaCnaGeneralPK == null && other.tablaCnaGeneralPK != null) || (this.tablaCnaGeneralPK != null && !this.tablaCnaGeneralPK.equals(other.tablaCnaGeneralPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.TablaCnaGeneral[ tablaCnaGeneralPK=" + tablaCnaGeneralPK + " ]";
    }
    
}
