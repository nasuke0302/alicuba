/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Roles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import repositorios.RolesRepo;

/**
 *
 * @author albert
 */
@Controller
public class gestionarRolesController {

    @Autowired
    RolesRepo repo;

    @RequestMapping(value = "/roles/gestionar")
    public ModelAndView showGestionarRoles() {
        return new ModelAndView("gestionarRoles");
    }

    @RequestMapping(value = "/roles/get")
    public @ResponseBody
    Map<String, ? extends Object> getUsuarios(Roles r) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", repo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/roles/add")
    public ModelAndView addRoles(@RequestBody Roles r) {
        repo.saveAndFlush(r);
        return showGestionarRoles();
    }

    @ResponseBody
    @RequestMapping(value = "/roles/edit")
    public ModelAndView editRoles(@RequestBody Roles r) {
        Roles r1 = repo.findOne(r.getIdRoles());
        r1.setTipoRol(r.getTipoRol());
        repo.saveAndFlush(r1);
        return showGestionarRoles();
    }

    @ResponseBody
    @RequestMapping(value = "/roles/delete")
    public ModelAndView leteRoles(@RequestBody Roles r) {
        repo.delete(r);
        return showGestionarRoles();
    }
}
