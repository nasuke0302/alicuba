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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.springframework.security.core.GrantedAuthority;

/**
 *
 * @author albert
 */
@Entity
@Table(name = "roles")
@NamedQueries({
    @NamedQuery(name = "Roles.findAll", query = "SELECT r FROM Roles r")})
public class Roles implements Serializable, GrantedAuthority {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_roles")
    private Integer idRoles;
    @Column(name = "tipo_rol")
    private String tipoRol;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idRol")
    @JsonIgnore
    private List<Usuarios> usuariosList;

    public Roles() {
    }

    public Roles(Integer idRoles) {
        this.idRoles = idRoles;
    }
    
    public Roles(String idRoles) {
        this.idRoles = Integer.parseInt(idRoles);
    }

    public Integer getIdRoles() {
        return idRoles;
    }

    public void setIdRoles(Integer idRoles) {
        this.idRoles = idRoles;
    }

    public String getTipoRol() {
        return tipoRol;
    }

    public void setTipoRol(String tipoRol) {
        this.tipoRol = tipoRol;
    }

    public List<Usuarios> getUsuariosList() {
        return usuariosList;
    }

    public void setUsuariosList(List<Usuarios> usuariosList) {
        this.usuariosList = usuariosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRoles != null ? idRoles.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Roles)) {
            return false;
        }
        Roles other = (Roles) object;
        if ((this.idRoles == null && other.idRoles != null) || (this.idRoles != null && !this.idRoles.equals(other.idRoles))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Roles[ idRoles=" + idRoles + " ]";
    }

    @Override
    @JsonIgnore
    public String getAuthority() {
        return tipoRol;
    }
    
}
