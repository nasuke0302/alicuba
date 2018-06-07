package models;

//import com.alastor.util.SerializadorFechaTraza;
//import org.hibernate.annotations.Cache;
//import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import services.SerializadorFechaTraza;

@Entity
@Table(name = "traza")
//@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
//@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "objeto"}, ignoreUnknown = true)
public class Traza implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_traza", nullable = false)
    private Integer idTraza;

    @Column(name = "url")
    private String url;

    @Column(name = "tiempo")
//    @Temporal(TemporalType.DATE)
//    @JsonSerialize(using = SerializadorFechaTraza.class)
    private String tiempo;

    @Column(name = "accion")
    private String accion;

    @Column(name = "tipo")
    private String tipo;

    @Column(name = "usuario")
    private String usuario;

    @Column(name = "clase")
    private String clase;

    @Column(name = "clase_entidad")
    private String claseEntidad;

    @Column(name = "clase_time_line")
    private String timeLineClase;

    public Traza() {
    }

    public Traza(String url, String tiempo, String accion, String usuario, String tipo) {
        this.url = url;
        this.tiempo = tiempo;
        this.accion = accion;
        this.usuario = usuario;
        this.tipo = tipo;
    }

    public Traza(Integer idTraza) {
        this.idTraza = idTraza;
    }

    public Integer getIdTraza() {
        return idTraza;
    }

    public void setIdTraza(Integer idTraza) {
        this.idTraza = idTraza;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTiempo() {
        return tiempo;
    }

    public void setTiempo(String tiempo) {
        this.tiempo = tiempo;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getClaseEntidad() {
        return claseEntidad;
    }

    public void setClaseEntidad(String claseEntidad) {
        this.claseEntidad = claseEntidad;
    }

    public String getTimeLineClase() {
        return timeLineClase;
    }

    public void setTimeLineClase(String timeLineClase) {
        this.timeLineClase = timeLineClase;
    }

}
