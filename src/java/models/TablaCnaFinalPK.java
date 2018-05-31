/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Feisy
 */
@Embeddable
public class TablaCnaFinalPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "id_metadatos_alimentos_tabla")
    private int idMetadatosAlimentosTabla;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_nutriente")
    private int idNutriente;

    public TablaCnaFinalPK() {
    }

    public TablaCnaFinalPK(int idMetadatosAlimentosTabla, int idNutriente) {
        this.idMetadatosAlimentosTabla = idMetadatosAlimentosTabla;
        this.idNutriente = idNutriente;
    }

    public int getIdMetadatosAlimentosTabla() {
        return idMetadatosAlimentosTabla;
    }

    public void setIdMetadatosAlimentosTabla(int idMetadatosAlimentosTabla) {
        this.idMetadatosAlimentosTabla = idMetadatosAlimentosTabla;
    }

    public int getIdNutriente() {
        return idNutriente;
    }

    public void setIdNutriente(int idNutriente) {
        this.idNutriente = idNutriente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idMetadatosAlimentosTabla;
        hash += (int) idNutriente;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TablaCnaFinalPK)) {
            return false;
        }
        TablaCnaFinalPK other = (TablaCnaFinalPK) object;
        if (this.idMetadatosAlimentosTabla != other.idMetadatosAlimentosTabla) {
            return false;
        }
        if (this.idNutriente != other.idNutriente) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.TablaCnaFinalPK[ idMetadatosAlimentosTabla=" + idMetadatosAlimentosTabla + ", idNutriente=" + idNutriente + " ]";
    }
    
}
