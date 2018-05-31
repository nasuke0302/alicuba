/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "listado_tabla_generadas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ListadoTablaGeneradas.findAll", query = "SELECT l FROM ListadoTablaGeneradas l"),
    @NamedQuery(name = "ListadoTablaGeneradas.findByIdListadoTablaGeneradas", query = "SELECT l FROM ListadoTablaGeneradas l WHERE l.idListadoTablaGeneradas = :idListadoTablaGeneradas"),
    @NamedQuery(name = "ListadoTablaGeneradas.findByNombre", query = "SELECT l FROM ListadoTablaGeneradas l WHERE l.nombre = :nombre"),
    @NamedQuery(name = "ListadoTablaGeneradas.findByFechaHora", query = "SELECT l FROM ListadoTablaGeneradas l WHERE l.fechaHora = :fechaHora")})
public class ListadoTablaGeneradas implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_listado_tabla_generadas")
    private Integer idListadoTablaGeneradas;
    @Size(max = 2147483647)
    @Column(name = "nombre")
    private String nombre;
    @Size(max = 2147483647)
    @Column(name = "fecha_hora")
    private String fechaHora;
    @OneToMany(mappedBy = "idListadoTablaGeneradas")
    private List<MetadatosAlimentosTabla> metadatosAlimentosTablaList;

    public ListadoTablaGeneradas() {
    }

    public ListadoTablaGeneradas(Integer idListadoTablaGeneradas) {
        this.idListadoTablaGeneradas = idListadoTablaGeneradas;
    }

    public Integer getIdListadoTablaGeneradas() {
        return idListadoTablaGeneradas;
    }

    public void setIdListadoTablaGeneradas(Integer idListadoTablaGeneradas) {
        this.idListadoTablaGeneradas = idListadoTablaGeneradas;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(String fechaHora) {
        this.fechaHora = fechaHora;
    }

    @XmlTransient
    public List<MetadatosAlimentosTabla> getMetadatosAlimentosTablaList() {
        return metadatosAlimentosTablaList;
    }

    public void setMetadatosAlimentosTablaList(List<MetadatosAlimentosTabla> metadatosAlimentosTablaList) {
        this.metadatosAlimentosTablaList = metadatosAlimentosTablaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idListadoTablaGeneradas != null ? idListadoTablaGeneradas.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ListadoTablaGeneradas)) {
            return false;
        }
        ListadoTablaGeneradas other = (ListadoTablaGeneradas) object;
        if ((this.idListadoTablaGeneradas == null && other.idListadoTablaGeneradas != null) || (this.idListadoTablaGeneradas != null && !this.idListadoTablaGeneradas.equals(other.idListadoTablaGeneradas))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.ListadoTablaGeneradas[ idListadoTablaGeneradas=" + idListadoTablaGeneradas + " ]";
    }
    
}
