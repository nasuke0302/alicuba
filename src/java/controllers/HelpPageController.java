/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Roles;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import repositorios.UsuariosRepo;

/**
 *
 * @author albert
 */
@Controller
public class HelpPageController {

    @Autowired
    UsuariosRepo usuariosRepo;

    @RequestMapping(value = "/helpPage")
    public String showHelpPage() {
        return "helpPage";
    }

    @RequestMapping(value = "/helpPage/getUsuariosAdministradores")
    public @ResponseBody
    Map<String, ? extends Object> getUsuariosAdministradores() {
        Map<String, Object> map = new HashMap<>();
        List<Usuarios> usuariosAdmins = usuariosRepo.findAllByIdRol(new Roles(1));
        map.put("data", usuariosAdmins);
        return map;
    }
    
    @RequestMapping(value = "/helpPage/getUsuariosEditores")
    public @ResponseBody
    Map<String, ? extends Object> getUsuariosEditores() {
        Map<String, Object> map = new HashMap<>();
        List<Usuarios> usuariosAdmins = usuariosRepo.findAllByIdRol(new Roles(3));
        map.put("data", usuariosAdmins);
        return map;
    }
}
