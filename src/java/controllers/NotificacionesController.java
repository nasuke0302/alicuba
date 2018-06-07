/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Mensaje;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.MensajeRepo;
import services.Trazable;

/**
 *
 * @author albert
 */
@Controller
public class NotificacionesController {

    @Autowired
    MensajeRepo mensajeRepo;

    @Trazable(accion = "listar", listar = true, nombre = "listarNotificaciones", timeLine = "", claseEntidad = "Notificaciones")
    @RequestMapping(value = "/notificaciones/gestionar")
    public ModelAndView showGestionarAutores() {
        return new ModelAndView("gestionarNotificaciones");
    }

    @RequestMapping(value = "/notificaciones/getNotificaciones")
    public @ResponseBody
    Map<String, ? extends Object> getNotificaciones(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        List<Mensaje> mensajes = mensajeRepo.findAllByReceiverOrderByFechaDesc(principal.getNombre().toLowerCase());
        mensajes.addAll(mensajeRepo.findAllByReceiverOrderByFechaDesc("todos"));
        try {
            map.put("data", mensajes);
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @DeleteMapping(value = "/notificaciones/deleteNotificacion/{id}")
    public ModelAndView deleteNotificaciones(@PathVariable Integer id, ModelMap map) {
        mensajeRepo.delete(id);
        map.put("mensaje", "Notificación eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @RequestMapping(value = "/notificaciones/setNotificacionesLeidas", method = RequestMethod.POST)
    public ModelAndView setNotificacionesLeidas(@RequestBody List<Mensaje> mensajesList) {
        Map<String, Object> map = new HashMap<>();
        for (int i = 0; i < mensajesList.size(); i++) {
            mensajesList.get(i).setLeido(Boolean.TRUE);
            mensajeRepo.saveAndFlush(mensajesList.get(i));
        }
        map.put("data", "Mensajes seteados como leidos");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
