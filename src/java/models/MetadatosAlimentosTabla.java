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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Feisy
 */
@Entity
@Table(name = "metadatos_alimentos_tabla")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MetadatosAlimentosTabla.findAll", query = "SELECT m FROM MetadatosAlimentosTabla m"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByIdMetadatosAlimentosTabla", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.idMetadatosAlimentosTabla = :idMetadatosAlimentosTabla"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByRiego", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.riego = :riego"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByN", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.n = :n"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByNpk", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.npk = :npk"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByEdad", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.edad = :edad"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByCorte", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.corte = :corte"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByTecnolog", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.tecnolog = :tecnolog"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByTratamiento", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.tratamiento = :tratamiento"),
    @NamedQuery(name = "MetadatosAlimentosTabla.findByPresentation", query = "SELECT m FROM MetadatosAlimentosTabla m WHERE m.presentation = :presentation")})
public class MetadatosAlimentosTabla implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_metadatos_alimentos_tabla")
    private Integer idMetadatosAlimentosTabla;
    @Size(max = 2147483647)
    @Column(name = "riego")
    private String riego;
    @Column(name = "n")
    private Integer n;
    @Size(max = 2147483647)
    @Column(name = "npk")
    private String npk;
    @Column(name = "edad")
    private Integer edad;
    @Size(max = 2147483647)
    @Column(name = "corte")
    private String corte;
    @Size(max = 2147483647)
    @Column(name = "tecnolog")
    private String tecnolog;
    @Size(max = 2147483647)
    @Column(name = "tratamiento")
    private String tratamiento;
    @Size(max = 2147483647)
    @Column(name = "presentation")
    private String presentation;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "metadatosAlimentosTabla")
    private List<TablaCnaFinal> tablaCnaFinalList;
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
    @JoinColumn(name = "id_listado_tabla_generadas", referencedColumnName = "id_listado_tabla_generadas")
    
    @ManyToOne
    @JsonIgnore
    private ListadoTablaGeneradas idListadoTablaGeneradas;
    
    @JoinColumn(name = "id_nivel_fert", referencedColumnName = "id_nivel_fert")
    @ManyToOne(optional = false)
    private NivelFert idNivelFert;
    @JoinColumn(name = "import", referencedColumnName = "id_paises")
    @ManyToOne
    private Paises import1;
    @JoinColumn(name = "id_rango_edades", referencedColumnName = "id_rango_edades")
    @ManyToOne(optional = false)
    private RangoEdades idRangoEdades;
    @JoinColumn(name = "id_region", referencedColumnName = "id_region")
    @ManyToOne(optional = false)
    private Region idRegion;

    public MetadatosAlimentosTabla() {
    }

    public MetadatosAlimentosTabla(Integer idMetadatosAlimentosTabla) {
        this.idMetadatosAlimentosTabla = idMetadatosAlimentosTabla;
    }

    public Integer getIdMetadatosAlimentosTabla() {
        return idMetadatosAlimentosTabla;
    }

    public void setIdMetadatosAlimentosTabla(Integer idMetadatosAlimentosTabla) {
        this.idMetadatosAlimentosTabla = idMetadatosAlimentosTabla;
    }

    public String getRiego() {
        return riego;
    }

    public void setRiego(String riego) {
        this.riego = riego;
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

    @XmlTransient
    public List<TablaCnaFinal> getTablaCnaFinalList() {
        return tablaCnaFinalList;
    }

    public void setTablaCnaFinalList(List<TablaCnaFinal> tablaCnaFinalList) {
        this.tablaCnaFinalList = tablaCnaFinalList;
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

    public ListadoTablaGeneradas getIdListadoTablaGeneradas() {
        return idListadoTablaGeneradas;
    }

    public void setIdListadoTablaGeneradas(ListadoTablaGeneradas idListadoTablaGeneradas) {
        this.idListadoTablaGeneradas = idListadoTablaGeneradas;
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

    public RangoEdades getIdRangoEdades() {
        return idRangoEdades;
    }

    public void setIdRangoEdades(RangoEdades idRangoEdades) {
        this.idRangoEdades = idRangoEdades;
    }

    public Region getIdRegion() {
        return idRegion;
    }

    public void setIdRegion(Region idRegion) {
        this.idRegion = idRegion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMetadatosAlimentosTabla != null ? idMetadatosAlimentosTabla.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MetadatosAlimentosTabla)) {
            return false;
        }
        MetadatosAlimentosTabla other = (MetadatosAlimentosTabla) object;
        if ((this.idMetadatosAlimentosTabla == null && other.idMetadatosAlimentosTabla != null) || (this.idMetadatosAlimentosTabla != null && !this.idMetadatosAlimentosTabla.equals(other.idMetadatosAlimentosTabla))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.MetadatosAlimentosTabla[ idMetadatosAlimentosTabla=" + idMetadatosAlimentosTabla + " ]";
    }
}
