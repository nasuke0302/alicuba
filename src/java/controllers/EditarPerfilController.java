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
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
public class EditarPerfilController {

    @Autowired
    UsuariosRepo repo;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @RequestMapping(value = "/editarPerfil/show")
    public ModelAndView showEditarPerfil() {
        return new ModelAndView("editarPerfil");
    }

    @RequestMapping(value = "/editarPerfil/getUsuarioAutenticado")
    public @ResponseBody
    Map<String, ? extends Object> getUsuarioAutenticado(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", repo.findByEmail(principal.getEmail()));
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/editarPerfil/updatePerfil")
    public ModelAndView editarPerfil(@RequestBody Usuarios u, ModelMap map) {
        Usuarios u1 = repo.findOne(u.getIdUsuario());
        u1.setEmail(u.getEmail());
        u1.setNombre(u.getNombre());
        u1.setApellidos(u.getApellidos());
        try {
            repo.saveAndFlush(u1);
            map.put("mensaje", "Perfil editado correctamente");
        } catch (Exception e) {
            map.put("mensaje", "Error al editar perfil");
            map.put("Error", e);
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @RequestMapping(value = "/editarPerfil/cambiarPassword")
    public ModelAndView cambiarPassword(@RequestBody String password, ModelMap map,
            @AuthenticationPrincipal Usuarios principal) {
        try {
            Usuarios u1 = (Usuarios) repo.findByNombreIgnoreCase(principal.getUsername());
            u1.setPassword(passwordEncoder.encode(password));
            repo.saveAndFlush(u1);
            map.put("mensaje", "Su contrase&ntilde;a ha sido cambiada correctamente");
        } catch (Exception e) {
            map.put("Error", "Error al cambiar su contraseña");
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
