/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Autores;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
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

/**
 *
 * @author albert
 */
@Controller
public class AutoresController {
    
    @Autowired
    AutoresRepo autoresRepo;
    
    @Secured(value= "Colaborador, Editor")
    @RequestMapping(value = "/autores/gestionar")
    public ModelAndView showGestionarAutores() {
        return new ModelAndView("gestionarAutores");
    }
    
    @Secured(value= "Colaborador, Editor")
    @RequestMapping(value = "/autores/getAutores")
    public @ResponseBody
    Map<String, ? extends Object> getAutores() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", autoresRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
    
    @Secured(value= "Colaborador")
    @ResponseBody
    @RequestMapping(value = "/autores/addAutor")
    public ModelAndView addAutor(@RequestBody Autores a, ModelMap map) {
        autoresRepo.saveAndFlush(a);
        map.put("mensaje", "Autor insertado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
    
    @Secured(value= "Colaborador, Editor")
    @ResponseBody
    @RequestMapping(value = "/autores/editAutor")
    public ModelAndView editAutores(@RequestBody Autores a, ModelMap map) {
        Autores a1 = autoresRepo.findOne(a.getIdAutor());
        a1.setNombre(a.getNombre());
        a1.setSegundoNombre(a.getSegundoNombre());
        a1.setApellidos(a.getApellidos());
        autoresRepo.saveAndFlush(a1);
        map.put("mensaje", "Autor editado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
    
    @Secured(value= "Colaborador")
    @RequestMapping(value = "/autores/deleteAutor/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteAutores(@PathVariable Integer id, ModelMap map) {
        autoresRepo.delete(id);
        map.put("mensaje", "Autor eliminado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
