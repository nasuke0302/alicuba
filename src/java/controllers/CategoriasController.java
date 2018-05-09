/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Categoria;
import models.Mensaje;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/categorias/gestionar")
    public ModelAndView showGestionarCategorias() {
        return new ModelAndView("gestionarCategorias");
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/categorias/get")
    public @ResponseBody
    Map<String, ? extends Object> getCategorias() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", categoriaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador")
    @ResponseBody
    @RequestMapping(value = "/categorias/add")
    public ModelAndView addCategorias(@RequestBody Categoria cat, ModelMap map) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
        }
        categoriaRepo.saveAndFlush(cat);
        map.put("mensaje", "Categoría insertada correctamente");
        map.put("data", cat);
        Mensaje msj = new Mensaje();
        msj.setMensaje(username + " ha insertado la categoría " + cat.getCategoria());
        mensajeRepo.saveAndFlush(msj);
        messagingTemplate.convertAndSend("/messages/enviar", msj);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador, Editor")
    @ResponseBody
    @RequestMapping(value = "/categorias/edit")
    public ModelAndView editCategorias(@RequestBody Categoria cat, ModelMap map) {
        Categoria cat1 = categoriaRepo.findOne(cat.getIdCategoria());
        cat1.setCategoria(cat.getCategoria());
        categoriaRepo.saveAndFlush(cat1);
        map.put("mensaje", "Categoría editada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador")
    @RequestMapping(value = "/categorias/delete/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteCategorias(@PathVariable Integer id, ModelMap map) {
        categoriaRepo.delete(id);
        map.put("mensaje", "Categoría eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
