/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Mensaje;
import models.Referencias;
import models.Roles;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.annotation.Secured;
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
import repositorios.CategoriaRepo;
import repositorios.FuenteInfRepo;
import repositorios.MensajeRepo;
import repositorios.ReferenciasRepo;

@Controller
public class IndexController {

    @Autowired
    ReferenciasRepo referenciasRepo;

    @Autowired
    AutoresRepo autoresRepo;

    @Autowired
    FuenteInfRepo fuenteInfRepo;

    @Autowired
    CategoriaRepo categoriasRepo;

    @Autowired
    SimpMessagingTemplate messagingTemplate;

    @Autowired
    MensajeRepo mensajeRepo;

    List<Mensaje> notificaciones;
    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

    @RequestMapping(value = {"/", "/index"})
    public ModelAndView showIndex() {
        return new ModelAndView("index");
    }

    @RequestMapping(value = {"/index/createOrEditReferencia"})
    public String showCreateOrEditReferencia() {
        return "createOrEditReferencia";
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/index/getReferencias")
    public @ResponseBody
    Map<String, ? extends Object> getReferencias(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        try {
            if ("Colaborador".equals(principal.getIdRol().toString())) {
                map.put("data", referenciasRepo.findAllByIdUsuario(principal));
            } else {
                map.put("data", referenciasRepo.findAll());
            }
            map.put("success", Boolean.TRUE);
        } catch (MessagingException e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e);
        }
        notificaciones = mensajeRepo.findAll();
        for (Mensaje notificacion : notificaciones) {
            messagingTemplate.convertAndSendToUser(notificacion.getReceiver(),
                    "/queue/notifications", notificacion);
        }
        return map;
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/index/getFuentes")
    public @ResponseBody
    Map<String, ? extends Object> getFuentes() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", fuenteInfRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador")
    @ResponseBody
    @RequestMapping(value = "/index/addReferencia")
    public ModelAndView addReferencia(@RequestBody Referencias r, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        r.setIdUsuario(principal);
        referenciasRepo.saveAndFlush(r);
        map.put("mensaje", "Referencia registrada correctamente");
        map.put("data", r);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador, Editor")
    @ResponseBody
    @RequestMapping(value = "/index/editReferencia")
    public ModelAndView editReferencia(@RequestBody Referencias r, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        Referencias r1 = referenciasRepo.findOne(r.getIdReferencia());
        r1 = r;
        try {
            referenciasRepo.saveAndFlush(r1);
            map.put("mensaje", "Referencia editada correctamente");
            map.put("data", r1);
            if ("Editor".equals(principal.getIdRol().toString())) {
                Mensaje mensaje = new Mensaje();
                Date fecha = new Date();
                mensaje.setFecha(dateFormat.format(fecha));
                mensaje.setLeido(Boolean.FALSE);
                mensaje.setSender(principal.getNombre());
                mensaje.setTitulo("Referencia editada");
                mensaje.setReceiver(r1.getIdUsuario().getNombre().toLowerCase());
                mensaje.setMensaje(principal.getNombre() + " ha editado la referencia con título: "
                        + r1.getTitle());
                mensajeRepo.saveAndFlush(mensaje);
                messagingTemplate.convertAndSendToUser(r1.getIdUsuario().getNombre().toLowerCase(),
                        "/queue/enviar", mensaje);
            }
        } catch (Exception e) {
            map.put("mensaje", "Error al actualizar la referencia");
            map.put("error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador")
    @RequestMapping(value = "/index/delete/{idReferencia}", method = RequestMethod.POST)
    public ModelAndView deleteReferencia(@PathVariable Integer idReferencia, ModelMap map) {
        try {
            referenciasRepo.delete(idReferencia);
            map.put("mensaje", "Referencia eliminada correctamente");
        } catch (Exception e) {
            map.put("Error", e);
            map.put("mensaje", "Error al eliminar la referencia");
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

}
