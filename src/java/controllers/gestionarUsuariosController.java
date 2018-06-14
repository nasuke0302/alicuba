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
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import services.Trazable;

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

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    @Trazable(accion = "listar", listar = true, nombre = "listarUsuarios", timeLine = "", claseEntidad = "Usuarios")
    @RequestMapping(value = "/usuarios/gestionar")
    public ModelAndView showGestionarUsuarios() {
        return new ModelAndView("gestionarUsuarios");
    }

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

    @Trazable(accion = "modificar", listar = true, nombre = "modificarUsuarios", timeLine = "", claseEntidad = "Usuarios")
    @ResponseBody
    @RequestMapping(value = "/usuarios/editUsuario")
    public ModelAndView editUsuario(@RequestBody Usuarios r, ModelMap map) {
        repo.saveAndFlush(r);
        Usuarios u = repo.findOne(r.getIdUsuario());
        map.put("mensaje", "Usuario editado correctamente");

        Mensaje mensaje = new Mensaje();
        Date fecha = new Date();
        mensaje.setFecha(dateFormat.format(fecha));
        mensaje.setLeido(Boolean.FALSE);
        mensaje.setMensaje(u.getNombre() + " " + u.getApellidos() + " es ahora " + u.getIdRol().getTipoRol() + " de AliCuba");
        mensaje.setTitulo("Usuario editado");
        mensaje.setSender(u.getNombre());
        mensaje.setReceiver("todos");
        mensajeRepo.saveAndFlush(mensaje);
        messagingTemplate.convertAndSend("/topic/notifications", mensaje);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Trazable(accion = "eliminar", eliminar = true, nombre = "eliminarUsuarios", timeLine = "", claseEntidad = "Usuarios")
    @ResponseBody
    @RequestMapping(value = "/usuarios/deleteUsuario/{idUsuario}")
    public ModelAndView deleteUsuario(@PathVariable Integer idUsuario, ModelMap map) {
        try {
            repo.delete(idUsuario);
            map.put("mensaje", "Usuario eliminado correctamente");
        } catch (Exception e) {
            map.put("mensaje", "Error al eliminar usuario");
            map.put("error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Trazable(accion = "modificar", modificar = true, nombre = "bloquearUsuarios", timeLine = "", claseEntidad = "Usuarios")
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

    @Trazable(accion = "modificar", modificar = true, nombre = "cambiarContraseñaUsuarios", timeLine = "", claseEntidad = "Usuarios")
    @ResponseBody
    @RequestMapping(value = "/usuarios/changePassword/{idUsuario}")
    public ModelAndView changePassword(@PathVariable Integer idUsuario, @RequestBody String pass, ModelMap map) {
        try {
            Usuarios u = repo.findOne(idUsuario);
            u.setPassword(passwordEncoder.encode(pass));
            repo.saveAndFlush(u);
            map.put("mensaje", "Contraseña cambiada correctamente");
        } catch (Exception e) {
            map.put("mensaje", "Error al cambiar la contraseña");
            map.put("error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
