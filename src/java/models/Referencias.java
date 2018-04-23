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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
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
@Table(name = "referencias")
@NamedQueries({
    @NamedQuery(name = "Referencias.findAll", query = "SELECT r FROM Referencias r")})
public class Referencias implements Serializable {

    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne
    private Usuarios idUsuario;
    @Column(name = "url")
    private String url;
    @ManyToMany
    @JoinTable(name = "categorias_por_referencias", joinColumns = {
        @JoinColumn(name = "id_referencia", referencedColumnName = "id_referencia")}, inverseJoinColumns = {
        @JoinColumn(name = "id_categoria", referencedColumnName = "id_categoria")})
    private List<Categoria> categoriaList;
    @ManyToMany
    @JoinTable(name = "autores_por_referencia", joinColumns = {
        @JoinColumn(name = "id_referencia", referencedColumnName = "id_referencia")}, inverseJoinColumns = {
        @JoinColumn(name = "id_autor", referencedColumnName = "id_autor")})
    private List<Autores> autoresList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_referencia")
    private Integer idReferencia;
    @Column(name = "nota")
    private String nota;
    @Column(name = "title")
    private String title;
    @Column(name = "informe_num")
    private String informeNum;
    @Column(name = "informe_tipo")
    private String informeTipo;
    @Column(name = "informe_serie")
    private String informeSerie;
    @Column(name = "informe_institution")
    private String informeInstitution;
    @Column(name = "arc_publication")
    private String arcPublication;
    @Column(name = "volumen")
    private String volumen;
    @Column(name = "num_vol")
    private String numVol;
    @Column(name = "edition")
    private String edition;
    @Column(name = "lugar")
    private String lugar;
    @Column(name = "editorial")
    private String editorial;
    @Column(name = "seccl_title")
    private String secclTitle;
    @Column(name = "tesis_universidad")
    private String tesisUniversidad;
    @Column(name = "pages")
    private String pages;
    @Column(name = "fecha")
    private String fecha;
    @Column(name = "fecha_ad")
    private String fechaAd;
    @Column(name = "fecha_mod")
    private String fechaMod;
    @JoinColumn(name = "id_fuente", referencedColumnName = "id_fuente")
    @ManyToOne(optional = false)
    private FuenteInf idFuente;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idReferencia")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;

    public Referencias() {
    }

    public Referencias(Integer idReferencia) {
        this.idReferencia = idReferencia;
    }

    public Integer getIdReferencia() {
        return idReferencia;
    }

    public void setIdReferencia(Integer idReferencia) {
        this.idReferencia = idReferencia;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getInformeNum() {
        return informeNum;
    }

    public void setInformeNum(String informeNum) {
        this.informeNum = informeNum;
    }

    public String getInformeTipo() {
        return informeTipo;
    }

    public void setInformeTipo(String informeTipo) {
        this.informeTipo = informeTipo;
    }

    public String getInformeSerie() {
        return informeSerie;
    }

    public void setInformeSerie(String informeSerie) {
        this.informeSerie = informeSerie;
    }

    public String getInformeInstitution() {
        return informeInstitution;
    }

    public void setInformeInstitution(String informeInstitution) {
        this.informeInstitution = informeInstitution;
    }

    public String getArcPublication() {
        return arcPublication;
    }

    public void setArcPublication(String arcPublication) {
        this.arcPublication = arcPublication;
    }

    public String getVolumen() {
        return volumen;
    }

    public void setVolumen(String volumen) {
        this.volumen = volumen;
    }

    public String getNumVol() {
        return numVol;
    }

    public void setNumVol(String numVol) {
        this.numVol = numVol;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public String getEditorial() {
        return editorial;
    }

    public void setEditorial(String editorial) {
        this.editorial = editorial;
    }

    public String getSecclTitle() {
        return secclTitle;
    }

    public void setSecclTitle(String secclTitle) {
        this.secclTitle = secclTitle;
    }

    public String getTesisUniversidad() {
        return tesisUniversidad;
    }

    public void setTesisUniversidad(String tesisUniversidad) {
        this.tesisUniversidad = tesisUniversidad;
    }

    public String getPages() {
        return pages;
    }

    public void setPages(String pages) {
        this.pages = pages;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getFechaAd() {
        return fechaAd;
    }

    public void setFechaAd(String fechaAd) {
        this.fechaAd = fechaAd;
    }

    public String getFechaMod() {
        return fechaMod;
    }

    public void setFechaMod(String fechaMod) {
        this.fechaMod = fechaMod;
    }

    public FuenteInf getIdFuente() {
        return idFuente;
    }

    public void setIdFuente(FuenteInf idFuente) {
        this.idFuente = idFuente;
    }

    public List<MetadatosAlimentosG> getMetadatosAlimentosGList() {
        return metadatosAlimentosGList;
    }

    public void setMetadatosAlimentosGList(List<MetadatosAlimentosG> metadatosAlimentosGList) {
        this.metadatosAlimentosGList = metadatosAlimentosGList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idReferencia != null ? idReferencia.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Referencias)) {
            return false;
        }
        Referencias other = (Referencias) object;
        if ((this.idReferencia == null && other.idReferencia != null) || (this.idReferencia != null && !this.idReferencia.equals(other.idReferencia))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Referencias[ idReferencia=" + idReferencia + " ]";
    }

    @XmlTransient
    public List<Autores> getAutoresList() {
        return autoresList;
    }

    public void setAutoresList(List<Autores> autoresList) {
        this.autoresList = autoresList;
    }

    @XmlTransient
    public List<Categoria> getCategoriaList() {
        return categoriaList;
    }

    public void setCategoriaList(List<Categoria> categoriaList) {
        this.categoriaList = categoriaList;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Usuarios getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuarios idUsuario) {
        this.idUsuario = idUsuario;
    }

}
