/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import models.Roles;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import repositorios.UsuariosRepo;

/**
 *
 * @author albert
 */
@Controller
public class LoginController {

    @Autowired
    UsuariosRepo repo;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "login";
    }

    @RequestMapping(value = "/addUsuarios", method = RequestMethod.POST)
    public String addUsuarios(@ModelAttribute Usuarios u, Model m, Roles rol, BindingResult result) {
        Usuarios u1 = repo.findByEmail(u.getEmail());
        u.setIdRol(new Roles(2));
        u.setPassword(passwordEncoder.encode(u.getPassword()));
        repo.saveAndFlush(u);
        return "redirect:/login";
    }
}
