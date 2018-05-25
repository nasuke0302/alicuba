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
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.MensajeRepo;

/**
 *
 * @author Tesis
 */
@Controller
public class HeaderController {

    @Autowired
    MensajeRepo mensajeRepo;

    @Secured(value = "Colabordaor, Editor")
    @RequestMapping(value = "/header/getMessages")
    public ModelAndView getMessages(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        List<Mensaje> mensajes = mensajeRepo.findAllByReceiverOrderByFechaDesc(principal.getNombre().toLowerCase());
        mensajes.addAll(mensajeRepo.findAllByReceiverOrderByFechaDesc("todos"));
        try {
            map.put("data", mensajes);
        } catch (Exception e) {
            map.put("error", e);
            map.put("mensaje", "Error al obtener lista de mensajes");
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
