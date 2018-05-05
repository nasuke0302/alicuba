/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.Roles;
import models.Usuarios;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author albert
 */
@Repository
public interface UsuariosRepo extends JpaRepository<Usuarios, Integer> {

    public Usuarios findByNombre(String string);
    
    public Usuarios findByEmail(String string);

    public Object findByNombreIgnoreCase(String username);

    public List<Usuarios> findAllByIdRol(Roles rol);
    
}
