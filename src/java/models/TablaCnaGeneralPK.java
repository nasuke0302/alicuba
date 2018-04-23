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

/**
 *
 * @author albert
 */
@Embeddable
public class TablaCnaGeneralPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "id_metadatos_alimentos_g")
    private int idMetadatosAlimentosG;
    @Basic(optional = false)
    @Column(name = "id_nutriente")
    private int idNutriente;

    public TablaCnaGeneralPK() {
    }

    public TablaCnaGeneralPK(int idMetadatosAlimentosG, int idNutriente) {
        this.idMetadatosAlimentosG = idMetadatosAlimentosG;
        this.idNutriente = idNutriente;
    }

    public int getIdMetadatosAlimentosG() {
        return idMetadatosAlimentosG;
    }

    public void setIdMetadatosAlimentosG(int idMetadatosAlimentosG) {
        this.idMetadatosAlimentosG = idMetadatosAlimentosG;
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
        hash += (int) idMetadatosAlimentosG;
        hash += (int) idNutriente;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TablaCnaGeneralPK)) {
            return false;
        }
        TablaCnaGeneralPK other = (TablaCnaGeneralPK) object;
        if (this.idMetadatosAlimentosG != other.idMetadatosAlimentosG) {
            return false;
        }
        if (this.idNutriente != other.idNutriente) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.TablaCnaGeneralPK[ idMetadatosAlimentosG=" + idMetadatosAlimentosG + ", idNutriente=" + idNutriente + " ]";
    }
    
}
