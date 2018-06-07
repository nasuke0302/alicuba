/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import models.Autores;
import models.Mensaje;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.AutoresRepo;
import repositorios.MensajeRepo;
import repositorios.TablatempRepo;
import services.Trazable;

/**
 *
 * @author albert
 */
@Controller
public class AutoresController {

    @Autowired
    AutoresRepo autoresRepo;

    @Autowired
    SimpMessagingTemplate messagingTemplate;

    @Autowired
    MensajeRepo mensajeRepo;

    @Autowired
    TablatempRepo tablaTempRepo;

    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    @Trazable(accion = "listar", listar = true, nombre = "listarAutores", timeLine = "", claseEntidad = "Autores")
    @RequestMapping(value = "/autores/gestionar")
    public ModelAndView showGestionarAutores() {
        return new ModelAndView("gestionarAutores");
    }

    @RequestMapping(value = "/autores/getAutores")
    @PreAuthorize(value = "hasAnyAuthority('Colaborador, Editor')")
    public @ResponseBody
    Map<String, ? extends Object> getAutores() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", autoresRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e);
        }
        return map;
    }

    @Trazable(accion = "insertar", insertar = true, nombre = "insertarAutores", timeLine = "", claseEntidad = "Autores")
    @ResponseBody
    @RequestMapping(value = "/autores/addAutor")
    public ModelAndView addAutor(@RequestBody Autores a, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        autoresRepo.saveAndFlush(a);
        map.put("mensaje", "Autor insertado correctamente");

        Mensaje mensaje = new Mensaje();
        Date fecha = new Date();
        mensaje.setFecha(dateFormat.format(fecha));
        mensaje.setLeido(Boolean.FALSE);
        mensaje.setMensaje(principal.getNombre() + " ha insertado un autor: " + a.getNombre());
        mensaje.setTitulo("Autor insertado");
        mensaje.setSender(principal.getNombre());
        mensaje.setReceiver("todos");
        mensajeRepo.saveAndFlush(mensaje);
        messagingTemplate.convertAndSend("/topic/notifications", mensaje);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Trazable(accion = "modificar", modificar = true, nombre = "modificarAutores", timeLine = "", claseEntidad = "Autores")
    @ResponseBody
    @RequestMapping(value = "/autores/editAutor")
    public ModelAndView editAutores(@RequestBody Autores a, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        Autores a1 = autoresRepo.findOne(a.getIdAutor());
        autoresRepo.saveAndFlush(a1);
        map.put("mensaje", "Autor editado correctamente");

        if ("Editor".equals(principal.getIdRol().toString())) {
            Mensaje mensaje = new Mensaje();
            Date fecha = new Date();
            mensaje.setFecha(dateFormat.format(fecha));
            mensaje.setLeido(Boolean.FALSE);
            mensaje.setMensaje(principal.getNombre() + " ha editado el autor: " + a1.getNombre());
            mensaje.setReceiver("colaboradores");
            mensaje.setTitulo("Autor editado");
            mensajeRepo.saveAndFlush(mensaje);
            messagingTemplate.convertAndSend("/topic/notifications", mensaje);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Trazable(accion = "eliminar", eliminar = true, nombre = "listarAutores", timeLine = "", claseEntidad = "Autores")
    @RequestMapping(value = "/autores/deleteAutor/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteAutores(@PathVariable Integer id, ModelMap map) {
        autoresRepo.delete(id);
        map.put("mensaje", "Autor eliminado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
