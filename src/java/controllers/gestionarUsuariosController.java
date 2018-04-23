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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.UsuariosRepo;

/**
 *
 * @author albert
 */
@Controller
public class gestionarUsuariosController {

    @Autowired
    UsuariosRepo repo;

    @Secured(value= "Administrador")
    @RequestMapping(value = "/usuarios/gestionar")
    public ModelAndView showGestionarUsuarios() {
        return new ModelAndView("gestionarUsuarios");
    }

    @Secured(value= "Administrador")
    @RequestMapping(value = "/usuarios/get")
    public @ResponseBody
    Map<String, ? extends Object> getUsuarios() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", repo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value= "Administrador")
    @ResponseBody
    @RequestMapping(value = "/usuarios/add")
    public ModelAndView addUsuario(@RequestBody Usuarios r, ModelMap map) {
        repo.saveAndFlush(r);
        map.put("mensaje", "Usuario insertado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value= "Administrador")
    @ResponseBody
    @RequestMapping(value = "/usuarios/edit")
    public ModelAndView editUsuario(@RequestBody Usuarios r, ModelMap map) {
        Usuarios u = repo.findOne(r.getIdUsuario());
        u.setEmail(r.getEmail());
        u.setNombre(r.getNombre());
        u.setApellidos(r.getApellidos());
        u.setIdRol(r.getIdRol());
        repo.saveAndFlush(u);
        map.put("mensaje", "Usuario editado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value= "Administrador")
    @ResponseBody
    @RequestMapping(value = "/usuarios/delete/{idUsuario}")
    public ModelAndView deleteUsuario(@PathVariable Integer idUsuario, ModelMap map) {
        repo.delete(idUsuario);
        map.put("mensaje", "Usuario eliminado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
