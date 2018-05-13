/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "metadatos_alimentos_g")
@NamedQueries({
    @NamedQuery(name = "MetadatosAlimentosG.findAll", query = "SELECT m FROM MetadatosAlimentosG m")})
public class MetadatosAlimentosG implements Serializable {

    @Column(name = "riego")
    private String riego;

//    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "metadatosAlimentosG")
    private List<TablaCnaGeneral> tablaCnaGeneralList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_metadatos_alimentos_g")
    private Integer idMetadatosAlimentosG;
    @Column(name = "n")
    private Integer n;
    @Column(name = "npk")
    private String npk;
    @Column(name = "edad")
    private Integer edad;
    @Column(name = "corte")
    private String corte;
    @Column(name = "tecnolog")
    private String tecnolog;
    @Column(name = "tratamiento")
    private String tratamiento;
    @Column(name = "presentation")
    private String presentation;
    @Column(name = "otras_caract")
    private String otrasCaract;
    @JoinColumn(name = "id_alimento", referencedColumnName = "id_alimento")
    @ManyToOne(optional = false)
    private Alimentos idAlimento;
    @JoinColumn(name = "calidad", referencedColumnName = "id_calidad")
    @ManyToOne(optional = false)
    private Calidad calidad;
    @JoinColumn(name = "id_epoca", referencedColumnName = "id_epoca")
    @ManyToOne(optional = false)
    private Epocas idEpoca;
    @JoinColumn(name = "fertilizado", referencedColumnName = "id_fertilizado")
    @ManyToOne(optional = false)
    private Fertilizado fertilizado;
    @JoinColumn(name = "mes_ini", referencedColumnName = "id_mes")
    @ManyToOne(optional = false)
    private Meses mesIni;
    @JoinColumn(name = "mes_fin", referencedColumnName = "id_mes")
    @ManyToOne(optional = false)
    private Meses mesFin;
    @JoinColumn(name = "id_nivel_fert", referencedColumnName = "id_nivel_fert")
    @ManyToOne(optional = false)
    private NivelFert idNivelFert;
    @JoinColumn(name = "import", referencedColumnName = "id_paises")
    @ManyToOne(optional = false)
    private Paises import1;
    @JoinColumn(name = "id_provincia", referencedColumnName = "id_provincia")
    @ManyToOne(optional = false)
    private Provincia idProvincia;
    @JoinColumn(name = "id_rango_edades", referencedColumnName = "id_rango_edades")
    @ManyToOne(optional = false)
    private RangoEdades idRangoEdades;
    @JoinColumn(name = "id_referencia", referencedColumnName = "id_referencia")
    @ManyToOne(optional = false)
    private Referencias idReferencia;

    public MetadatosAlimentosG() {
    }

    public MetadatosAlimentosG(Integer idMetadatosAlimentosG) {
        this.idMetadatosAlimentosG = idMetadatosAlimentosG;
    }

    public Integer getIdMetadatosAlimentosG() {
        return idMetadatosAlimentosG;
    }

    public void setIdMetadatosAlimentosG(Integer idMetadatosAlimentosG) {
        this.idMetadatosAlimentosG = idMetadatosAlimentosG;
    }


    public Integer getN() {
        return n;
    }

    public void setN(Integer n) {
        this.n = n;
    }

    public String getNpk() {
        return npk;
    }

    public void setNpk(String npk) {
        this.npk = npk;
    }

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

    public String getCorte() {
        return corte;
    }

    public void setCorte(String corte) {
        this.corte = corte;
    }

    public String getTecnolog() {
        return tecnolog;
    }

    public void setTecnolog(String tecnolog) {
        this.tecnolog = tecnolog;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    public String getPresentation() {
        return presentation;
    }

    public void setPresentation(String presentation) {
        this.presentation = presentation;
    }

    public String getOtrasCaract() {
        return otrasCaract;
    }

    public void setOtrasCaract(String otrasCaract) {
        this.otrasCaract = otrasCaract;
    }

    public Alimentos getIdAlimento() {
        return idAlimento;
    }

    public void setIdAlimento(Alimentos idAlimento) {
        this.idAlimento = idAlimento;
    }

    public Calidad getCalidad() {
        return calidad;
    }

    public void setCalidad(Calidad calidad) {
        this.calidad = calidad;
    }

    public Epocas getIdEpoca() {
        return idEpoca;
    }

    public void setIdEpoca(Epocas idEpoca) {
        this.idEpoca = idEpoca;
    }

    public Fertilizado getFertilizado() {
        return fertilizado;
    }

    public void setFertilizado(Fertilizado fertilizado) {
        this.fertilizado = fertilizado;
    }

    public Meses getMesIni() {
        return mesIni;
    }

    public void setMesIni(Meses mesIni) {
        this.mesIni = mesIni;
    }

    public Meses getMesFin() {
        return mesFin;
    }

    public void setMesFin(Meses mesFin) {
        this.mesFin = mesFin;
    }

    public NivelFert getIdNivelFert() {
        return idNivelFert;
    }

    public void setIdNivelFert(NivelFert idNivelFert) {
        this.idNivelFert = idNivelFert;
    }

    public Paises getImport1() {
        return import1;
    }

    public void setImport1(Paises import1) {
        this.import1 = import1;
    }

    public Provincia getIdProvincia() {
        return idProvincia;
    }

    public void setIdProvincia(Provincia idProvincia) {
        this.idProvincia = idProvincia;
    }

    public RangoEdades getIdRangoEdades() {
        return idRangoEdades;
    }

    public void setIdRangoEdades(RangoEdades idRangoEdades) {
        this.idRangoEdades = idRangoEdades;
    }

    public Referencias getIdReferencia() {
        return idReferencia;
    }

    public void setIdReferencia(Referencias idReferencia) {
        this.idReferencia = idReferencia;
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
        if (!(object instanceof MetadatosAlimentosG)) {
            return false;
        }
        MetadatosAlimentosG other = (MetadatosAlimentosG) object;
        if ((this.idMetadatosAlimentosG == null && other.idMetadatosAlimentosG != null) || (this.idMetadatosAlimentosG != null && !this.idMetadatosAlimentosG.equals(other.idMetadatosAlimentosG))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.MetadatosAlimentosG[ idMetadatosAlimentosG=" + idMetadatosAlimentosG + " ]";
    }

    @XmlTransient
    public List<TablaCnaGeneral> getTablaCnaGeneralList() {
        return tablaCnaGeneralList;
    }

    public void setTablaCnaGeneralList(List<TablaCnaGeneral> tablaCnaGeneralList) {
        this.tablaCnaGeneralList = tablaCnaGeneralList;
    }

    public String getRiego() {
        return riego;
    }

    public void setRiego(String riego) {
        this.riego = riego;
    }

}
