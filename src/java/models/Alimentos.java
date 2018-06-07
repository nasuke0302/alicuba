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
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "alimentos")
@NamedQueries({
    @NamedQuery(name = "Alimentos.findAll", query = "SELECT a FROM Alimentos a")})
public class Alimentos implements Serializable {

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idAlimento")
    private List<MetadatosAlimentosTabla> metadatosAlimentosTablaList;

    @Column(name = "proceso")
    private String proceso;
    @Column(name = "mezcla")
    private String mezcla;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_alimento")
    private Integer idAlimento;
    @Column(name = "nombre_cient")
    private String nombreCient;
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "variedad")
    private String variedad;
    @Column(name = "parte")
    private String parte;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idAlimento")
    @JsonIgnore
    private List<MetadatosAlimentosG> metadatosAlimentosGList;
    @JoinColumn(name = "id_tipo_cuba", referencedColumnName = "id_tipo_cuba")
    @ManyToOne(optional = false)
    private TipoCuba idTipoCuba;
    @JoinColumn(name = "id_tipo_fao", referencedColumnName = "id_tipo_fao")
    @ManyToOne(optional = false)
    private TipoFao idTipoFao;
    @JoinColumn(name = "id_tipo_nrc", referencedColumnName = "id_tipo_nrc")
    @ManyToOne(optional = false)
    private TipoNrc idTipoNrc;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuarios idUsuario;

    public Alimentos() {
    }

    public Alimentos(Integer idAlimento) {
        this.idAlimento = idAlimento;
    }

    public Integer getIdAlimento() {
        return idAlimento;
    }

    public void setIdAlimento(Integer idAlimento) {
        this.idAlimento = idAlimento;
    }

    public String getNombreCient() {
        return nombreCient;
    }

    public void setNombreCient(String nombreCient) {
        this.nombreCient = nombreCient;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getVariedad() {
        return variedad;
    }

    public void setVariedad(String variedad) {
        this.variedad = variedad;
    }

    public String getParte() {
        return parte;
    }

    public void setParte(String parte) {
        this.parte = parte;
    }

    public List<MetadatosAlimentosG> getMetadatosAlimentosGList() {
        return metadatosAlimentosGList;
    }

    public void setMetadatosAlimentosGList(List<MetadatosAlimentosG> metadatosAlimentosGList) {
        this.metadatosAlimentosGList = metadatosAlimentosGList;
    }

    public TipoCuba getIdTipoCuba() {
        return idTipoCuba;
    }

    public void setIdTipoCuba(TipoCuba idTipoCuba) {
        this.idTipoCuba = idTipoCuba;
    }

    public TipoFao getIdTipoFao() {
        return idTipoFao;
    }

    public void setIdTipoFao(TipoFao idTipoFao) {
        this.idTipoFao = idTipoFao;
    }

    public TipoNrc getIdTipoNrc() {
        return idTipoNrc;
    }

    public void setIdTipoNrc(TipoNrc idTipoNrc) {
        this.idTipoNrc = idTipoNrc;
    }

    public Usuarios getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuarios idUsuario) {
        this.idUsuario = idUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAlimento != null ? idAlimento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Alimentos)) {
            return false;
        }
        Alimentos other = (Alimentos) object;
        if ((this.idAlimento == null && other.idAlimento != null) || (this.idAlimento != null && !this.idAlimento.equals(other.idAlimento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Alimentos[ idAlimento=" + idAlimento + " ]";
    }

    public String getProceso() {
        return proceso;
    }

    public void setProceso(String proceso) {
        this.proceso = proceso;
    }

    public String getMezcla() {
        return mezcla;
    }

    public void setMezcla(String mezcla) {
        this.mezcla = mezcla;
    }

    @XmlTransient
    public List<MetadatosAlimentosTabla> getMetadatosAlimentosTablaList() {
        return metadatosAlimentosTablaList;
    }

    public void setMetadatosAlimentosTablaList(List<MetadatosAlimentosTabla> metadatosAlimentosTablaList) {
        this.metadatosAlimentosTablaList = metadatosAlimentosTablaList;
    }
    
}
