/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

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
 * @author Feisy
 */
@Entity
@Table(name = "tabla_cna_final")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TablaCnaFinal.findAll", query = "SELECT t FROM TablaCnaFinal t"),
    @NamedQuery(name = "TablaCnaFinal.findByIdMetadatosAlimentosTabla", query = "SELECT t FROM TablaCnaFinal t WHERE t.tablaCnaFinalPK.idMetadatosAlimentosTabla = :idMetadatosAlimentosTabla"),
    @NamedQuery(name = "TablaCnaFinal.findByIdNutriente", query = "SELECT t FROM TablaCnaFinal t WHERE t.tablaCnaFinalPK.idNutriente = :idNutriente"),
    @NamedQuery(name = "TablaCnaFinal.findByTotal", query = "SELECT t FROM TablaCnaFinal t WHERE t.total = :total"),
    @NamedQuery(name = "TablaCnaFinal.findByPromedio", query = "SELECT t FROM TablaCnaFinal t WHERE t.promedio = :promedio"),
    @NamedQuery(name = "TablaCnaFinal.findByMinimo", query = "SELECT t FROM TablaCnaFinal t WHERE t.minimo = :minimo"),
    @NamedQuery(name = "TablaCnaFinal.findByMaximo", query = "SELECT t FROM TablaCnaFinal t WHERE t.maximo = :maximo"),
    @NamedQuery(name = "TablaCnaFinal.findByDesvEst", query = "SELECT t FROM TablaCnaFinal t WHERE t.desvEst = :desvEst"),
    @NamedQuery(name = "TablaCnaFinal.findByVarianza", query = "SELECT t FROM TablaCnaFinal t WHERE t.varianza = :varianza")})
public class TablaCnaFinal implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TablaCnaFinalPK tablaCnaFinalPK;
    @Column(name = "total")
    private Integer total;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "promedio")
    private Float promedio;
    @Column(name = "minimo")
    private Float minimo;
    @Column(name = "maximo")
    private Float maximo;
    @Column(name = "desv_est")
    private Float desvEst;
    @Column(name = "varianza")
    private Float varianza;
    @JoinColumn(name = "id_metadatos_alimentos_tabla", referencedColumnName = "id_metadatos_alimentos_tabla", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private MetadatosAlimentosTabla metadatosAlimentosTabla;
    @JoinColumn(name = "id_nutriente", referencedColumnName = "id_nutriente", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Nutrientes nutrientes;

    public TablaCnaFinal() {
    }

    public TablaCnaFinal(TablaCnaFinalPK tablaCnaFinalPK) {
        this.tablaCnaFinalPK = tablaCnaFinalPK;
    }

    public TablaCnaFinal(int idMetadatosAlimentosTabla, int idNutriente) {
        this.tablaCnaFinalPK = new TablaCnaFinalPK(idMetadatosAlimentosTabla, idNutriente);
    }

    public TablaCnaFinalPK getTablaCnaFinalPK() {
        return tablaCnaFinalPK;
    }

    public void setTablaCnaFinalPK(TablaCnaFinalPK tablaCnaFinalPK) {
        this.tablaCnaFinalPK = tablaCnaFinalPK;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Float getPromedio() {
        return promedio;
    }

    public void setPromedio(Float promedio) {
        this.promedio = promedio;
    }

    public Float getMinimo() {
        return minimo;
    }

    public void setMinimo(Float minimo) {
        this.minimo = minimo;
    }

    public Float getMaximo() {
        return maximo;
    }

    public void setMaximo(Float maximo) {
        this.maximo = maximo;
    }

    public Float getDesvEst() {
        return desvEst;
    }

    public void setDesvEst(Float desvEst) {
        this.desvEst = desvEst;
    }

    public Float getVarianza() {
        return varianza;
    }

    public void setVarianza(Float varianza) {
        this.varianza = varianza;
    }

    public MetadatosAlimentosTabla getMetadatosAlimentosTabla() {
        return metadatosAlimentosTabla;
    }

    public void setMetadatosAlimentosTabla(MetadatosAlimentosTabla metadatosAlimentosTabla) {
        this.metadatosAlimentosTabla = metadatosAlimentosTabla;
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
        hash += (tablaCnaFinalPK != null ? tablaCnaFinalPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TablaCnaFinal)) {
            return false;
        }
        TablaCnaFinal other = (TablaCnaFinal) object;
        if ((this.tablaCnaFinalPK == null && other.tablaCnaFinalPK != null) || (this.tablaCnaFinalPK != null && !this.tablaCnaFinalPK.equals(other.tablaCnaFinalPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.TablaCnaFinal[ tablaCnaFinalPK=" + tablaCnaFinalPK + " ]";
    }
    
}
