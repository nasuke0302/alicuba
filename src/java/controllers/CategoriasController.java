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
import models.Categoria;
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
import repositorios.CategoriaRepo;
import repositorios.MensajeRepo;

/**
 *
 * @author albert
 */
@Controller
public class CategoriasController {

    @Autowired
    CategoriaRepo categoriaRepo;

    @Autowired
    SimpMessagingTemplate messagingTemplate;

    @Autowired
    MensajeRepo mensajeRepo;

    String username = "";
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/categorias/gestionar")
    public ModelAndView showGestionarCategorias() {
        return new ModelAndView("gestionarCategorias");
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/categorias/getCategorias")
    public @ResponseBody
    Map<String, ? extends Object> getCategorias(@AuthenticationPrincipal Usuarios usuario) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", categoriaRepo.findAll());
            map.put("success", Boolean.TRUE);
            map.put("user", usuario.getEmail());
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador")
    @ResponseBody
    @RequestMapping(value = "/categorias/addCategoria")
    public ModelAndView addCategorias(@RequestBody Categoria cat, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        categoriaRepo.saveAndFlush(cat);
        map.put("mensaje", "Categoría insertada correctamente");
        map.put("data", cat);
        
        Mensaje msj = new Mensaje();
        msj.setSender(principal.getNombre());
        Date fecha = new Date();
        msj.setTitulo("Nueva categoría");
        msj.setFecha(dateFormat.format(fecha));
        msj.setMensaje(principal.getNombre() + " ha insertado la categoría: " + cat.getCategoria());
        msj.setReceiver("todos");
        mensajeRepo.saveAndFlush(msj);
        messagingTemplate.convertAndSend("/topic/notifications", msj);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador, Editor")
    @ResponseBody
    @RequestMapping(value = "/categorias/editCategoria")
    public ModelAndView editCategorias(@RequestBody Categoria cat, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        Categoria cat1 = categoriaRepo.findOne(cat.getIdCategoria());
        categoriaRepo.saveAndFlush(cat1);
        map.put("mensaje", "Categoría editada correctamente");
        if ("Editor".equals(principal.getIdRol().toString())) {
            Mensaje mensaje = new Mensaje();
            Date fecha = new Date();
            mensaje.setFecha(dateFormat.format(fecha));
            mensaje.setLeido(Boolean.FALSE);
            mensaje.setMensaje(principal.getNombre() + " ha editado la categoría: " + cat1.getCategoria());
            mensaje.setReceiver("todos");
            mensaje.setTitulo("Categoría editada");
            mensajeRepo.saveAndFlush(mensaje);
            messagingTemplate.convertAndSend("/topic/notifications", mensaje);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador")
    @RequestMapping(value = "/categorias/deleteCategoria/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteCategorias(@PathVariable Integer id, ModelMap map) {
        categoriaRepo.delete(id);
        map.put("mensaje", "Categoría eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
