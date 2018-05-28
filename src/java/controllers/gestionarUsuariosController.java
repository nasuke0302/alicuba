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
import java.util.List;
import java.util.Map;
import models.Mensaje;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.MensajeRepo;
import repositorios.UsuariosRepo;

/**
 *
 * @author albert
 */
@Controller
public class gestionarUsuariosController {

    @Autowired
    UsuariosRepo repo;
    @Autowired
    SimpMessagingTemplate messagingTemplate;
    @Autowired
    MensajeRepo mensajeRepo;

    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    @Secured(value = "Administrador")
    @RequestMapping(value = "/usuarios/gestionar")
    public ModelAndView showGestionarUsuarios() {
        return new ModelAndView("gestionarUsuarios");
    }

    @Secured(value = "Administrador")
    @RequestMapping(value = "/usuarios/getUsuarios")
    public @ResponseBody
    Map<String, ? extends Object> getUsuarios(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        List<Usuarios> usuariosList = repo.findAll();
        usuariosList.remove(principal);
        try {
            map.put("data", usuariosList);
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Administrador")
    @ResponseBody
    @RequestMapping(value = "/usuarios/editUsuario")
    public ModelAndView editUsuario(@RequestBody Usuarios r, ModelMap map) {
        Usuarios u = repo.findOne(r.getIdUsuario());
        u.setEmail(r.getEmail());
        u.setNombre(r.getNombre());
        u.setApellidos(r.getApellidos());
        u.setIdRol(r.getIdRol());
        repo.saveAndFlush(u);
        map.put("mensaje", "Usuario editado correctamente");

        Mensaje mensaje = new Mensaje();
        Date fecha = new Date();
        mensaje.setFecha(dateFormat.format(fecha));
        mensaje.setLeido(Boolean.FALSE);
        mensaje.setMensaje(u.getNombre() + " es ahora " + u.getIdRol().getTipoRol() + " de AliCuba");
        mensaje.setTitulo("Usuario editado");
        mensaje.setSender(u.getNombre());
        mensaje.setReceiver("todos");
        mensajeRepo.saveAndFlush(mensaje);
        messagingTemplate.convertAndSend("/topic/notifications", mensaje);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Administrador")
    @ResponseBody
    @RequestMapping(value = "/usuarios/deleteUsuario/{idUsuario}")
    public ModelAndView deleteUsuario(@PathVariable Integer idUsuario, ModelMap map) {
        repo.delete(idUsuario);
        map.put("mensaje", "Usuario eliminado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Administrador")
    @ResponseBody
    @RequestMapping(value = "/usuarios/lockUser/{idUsuario}")
    public ModelAndView lockUser(@PathVariable Integer idUsuario, ModelMap map) {
        Usuarios u = repo.findOne(idUsuario);
        if (u.getActivo()) {
            u.setActivo(Boolean.FALSE);
            repo.saveAndFlush(u);
            map.put("mensaje", "Usuario desactivado");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }
        u.setActivo(Boolean.TRUE);
        repo.saveAndFlush(u);
        map.put("mensaje", "Usuario activado");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
