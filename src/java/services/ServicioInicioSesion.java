package services;

import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import repositorios.UsuariosRepo;

/**
 *
 * @author albert
 */
@Service
public class ServicioInicioSesion implements UserDetailsService {

    @Autowired
    UsuariosRepo repo;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Usuarios usuario = repo.findByEmail(email);
        if (usuario == null) {
            throw new UsernameNotFoundException("Usuario con email" + email + "  no encontrado");
        }
        return usuario;
    }
}
