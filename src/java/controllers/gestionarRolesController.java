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
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import repositorios.RolesRepo;

/**
 *
 * @author albert
 */
@Controller
public class gestionarRolesController {

    @Autowired
    RolesRepo repo;

    @Secured(value= "Administrador")
    @RequestMapping(value = "/roles/get")
    public @ResponseBody
    Map<String, ? extends Object> getRoles(Roles r) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", repo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
}
