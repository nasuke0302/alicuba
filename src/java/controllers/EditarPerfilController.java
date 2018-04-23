/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import repositorios.UsuariosRepo;

/**
 *
 * @author albert
 */
@Controller
public class EditarPerfilController {
    
    @Autowired
    UsuariosRepo repo;
    
    @RequestMapping(value = "/editarPerfil")
    public String showEditarPerfil(){
        return "editarPerfil";
    }
    
    @PostMapping(value = "/updatePerfil")
    public void editarPerfil(@ModelAttribute Usuarios u){
        Usuarios u1 = repo.findOne(u.getIdUsuario());
        repo.saveAndFlush(u1);
    }
}
