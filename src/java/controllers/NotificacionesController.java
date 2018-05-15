/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.MensajeRepo;

/**
 *
 * @author albert
 */
@Controller
public class NotificacionesController {
    
    @Autowired
    MensajeRepo mensajeRepo;
    
    @Secured(value= "Colaborador, Editor")
    @RequestMapping(value = "/notificaciones/gestionar")
    public ModelAndView showGestionarAutores() {
        return new ModelAndView("gestionarNotificaciones");
    }
    
    @Secured(value= "Colaborador, Editor")
    @RequestMapping(value = "/notificaciones/getNotificaciones")
    public @ResponseBody
    Map<String, ? extends Object> getNotificaciones(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", mensajeRepo.findAllByReceiverOrderByFechaDesc(principal.getNombre().toLowerCase()));
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
    
    @Secured(value= "Colaborador, Editor")
    @RequestMapping(value = "/notificaciones/deleteNotificacion/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteNotificaciones(@PathVariable Integer id, ModelMap map) {
        mensajeRepo.delete(id);
        map.put("mensaje", "Notificación eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
