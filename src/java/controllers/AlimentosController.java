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
import models.Alimentos;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.AlimentosRepo;
import repositorios.MensajeRepo;
import repositorios.TipoCubaRepo;
import repositorios.TipoFaoRepo;
import repositorios.TipoNrcRepo;
import services.Trazable;

/**
 *
 * @author albert
 */
@Controller
public class AlimentosController {

    @Autowired
    AlimentosRepo alimentosRepo;
    @Autowired
    TipoCubaRepo tipoCubaRepo;
    @Autowired
    TipoFaoRepo tipoFaoRepo;
    @Autowired
    TipoNrcRepo tipoNrcRepo;
    @Autowired
    SimpMessagingTemplate messagingTemplate;
    @Autowired
    MensajeRepo mensajeRepo;

    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    @Trazable(accion = "listar", listar = true, nombre = "listarAlimentos", timeLine = "", claseEntidad = "Alimentos")
    @RequestMapping(value = "/alimentos/gestionar")
    public ModelAndView showGestionarAlimentos() {
        return new ModelAndView("gestionarAlimentos");
    }

    @RequestMapping(value = "/alimentos/getAlimentos")
    public @ResponseBody
    Map<String, ? extends Object> getAlimentos(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        try {
            if ("Colaborador".equals(principal.getIdRol().toString())) {
                map.put("data", alimentosRepo.findAllByIdUsuario(principal));
            } else {
                map.put("data", alimentosRepo.findAll());
            }
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e);
        }
        return map;
    }

    @RequestMapping(value = "/alimentos/getAllTipoCuba")
    public @ResponseBody
    Map<String, ? extends Object> getAllTipoCuba() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", tipoCubaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/alimentos/getAllTipoFao")
    public @ResponseBody
    Map<String, ? extends Object> getAllTipoFao() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", tipoFaoRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/alimentos/getAllTipoNrc")
    public @ResponseBody
    Map<String, ? extends Object> getallTipoNrc() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", tipoNrcRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Trazable(accion = "insertar", insertar = true, nombre = "insertarAlimentos", timeLine = "", claseEntidad = "Alimentos")
    @ResponseBody
    @RequestMapping(value = "/alimentos/addAlimento")
    public ModelAndView addAlimento(@RequestBody Alimentos r, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        r.setIdUsuario(principal);
        alimentosRepo.saveAndFlush(r);
        map.put("mensaje", "Alimento insertado correctamente");
        
        Mensaje mensaje = new Mensaje();
        Date fecha = new Date();
        mensaje.setFecha(dateFormat.format(fecha));
        mensaje.setLeido(Boolean.FALSE);
        mensaje.setMensaje(principal.getNombre() + " ha insertado un alimento: " + r.getNombre());
        mensaje.setTitulo("Alimento insertado");
        mensaje.setSender(principal.getNombre());
        mensaje.setReceiver("editores");
        mensajeRepo.saveAndFlush(mensaje);
        messagingTemplate.convertAndSend("/topic/notifications", mensaje);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Trazable(accion = "modificar", modificar = true, nombre = "modificarAlimentos", timeLine = "", claseEntidad = "Alimentos")
    @ResponseBody
    @RequestMapping(value = "/alimentos/editAlimento")
    public ModelAndView editAlimentos(@RequestBody Alimentos r, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        Alimentos r1 = alimentosRepo.findOne(r.getIdAlimento());
        r1 = r;
        try {
            alimentosRepo.saveAndFlush(r1);
            map.put("mensaje", "Alimento editado correctamente");
            map.put("data", r1);
            if ("Editor".equals(principal.getIdRol().toString())) {
                Mensaje mensaje = new Mensaje();
                Date fecha = new Date();
                mensaje.setFecha( dateFormat.format(fecha));
                mensaje.setLeido(Boolean.FALSE);
                mensaje.setMensaje(principal.getNombre() + " ha editado el alimento: "
                        + r1.getNombreCient());
                mensajeRepo.saveAndFlush(mensaje);
                messagingTemplate.convertAndSendToUser(r1.getIdUsuario().getNombre().toLowerCase(),
                        "/queue/enviar", mensaje);
            }
        } catch (Exception e) {
            map.put("mensaje", "Error al actualizar el alimento");
            map.put("error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Trazable(accion = "eliminar", eliminar = true, nombre = "eliminarAlimentos", timeLine = "", claseEntidad = "Alimentos")
    @RequestMapping(value = "/alimentos/deleteAlimento/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteAlimento(@PathVariable Integer id, ModelMap map) {
        alimentosRepo.delete(id);
        map.put("mensaje", "Alimento eliminado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
